From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 04:28:36 -0800
Subject: [PXA320] How to find I/O registers, base address of ASIX ethernet
	chip?
In-Reply-To: <19621265275300@webmail108.yandex.ru>
References: <19621265275300@webmail108.yandex.ru>
Message-ID: <f17812d71002040428w75a734f0i8e7d9cba270f5483@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2010 at 1:21 AM, Dennis Semakin <insane79@yandex.ru> wrote:
> Hello all
>
> Configuration:
> Computer module is Toradex Colibri PXA320.
> Board is Colibri Evaluation Board.
>
> Obviously, to access the I/O register of network card, we need to map them into memory, using the ioremap() function.
> To do this driver (ax88796.c) use platform_get_resource() function to get the physical address of the I/O registers from the board definition (arch/arm/mach-pxa/colibri-pxa320.c). This function returns a pointer to a struct resource, which contains two interesting fields : start and end (both are physical address).
> Then call ioremap function to remap the memory area returned by platform_get_resource.
> Right?
>
> Ok. When I start kernel on my board, kernel loading stops on network initialization during call to the address resource.start.

By 'call', my understanding is 'access' here right?

> So, what could I do if the address (field start in resource structure) is not valid?
> Can I find it? (I mean address) Maybe I should ask something: where are ethernet chip I/O registers mapped in the memory?
>

Well, I guess you have to ask Toradex then :-)

Sometimes the registers range is offset by some value, possibly due
to compatibility with ISA I/O range, so you can also check if you have
a correct offset there in the resource definitions.

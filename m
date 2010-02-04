From: insane79@yandex.ru (Dennis Semakin)
Date: Thu, 04 Feb 2010 12:21:40 +0300
Subject: [PXA320] How to find  I/O registers,
	base address of ASIX ethernet chip?
Message-ID: <19621265275300@webmail108.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all

Configuration:
Computer module is Toradex Colibri PXA320.
Board is Colibri Evaluation Board.

Obviously, to access the I/O register of network card, we need to map them into memory, using the ioremap() function.
To do this driver (ax88796.c) use platform_get_resource() function to get the physical address of the I/O registers from the board definition (arch/arm/mach-pxa/colibri-pxa320.c). This function returns a pointer to a struct resource, which contains two interesting fields : start and end (both are physical address).
Then call ioremap function to remap the memory area returned by platform_get_resource.
Right?

Ok. When I start kernel on my board, kernel loading stops on network initialization during call to the address resource.start.
So, what could I do if the address (field start in resource structure) is not valid?
Can I find it? (I mean address) Maybe I should ask something: where are ethernet chip I/O registers mapped in the memory?

Thanks
Best regards
Dennis Semakin

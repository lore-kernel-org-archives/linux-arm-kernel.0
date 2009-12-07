From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 7 Dec 2009 09:39:04 -0200
Subject: [PATCH] mx27: mxt_td60: Add USB Support
In-Reply-To: <20091204180554.GX14091@buzzloop.caiaq.de>
References: <1259948719-10008-1-git-send-email-acassis@gmail.com>
	<20091204180554.GX14091@buzzloop.caiaq.de>
Message-ID: <37367b3a0912070339o44b6badcjbcd47034f5589b72@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 12/4/09, Daniel Mack <daniel@caiaq.de> wrote:
> On Fri, Dec 04, 2009 at 03:45:19PM -0200, Alan Carvalho de Assis wrote:
>> This patch add USB support on i-MXT TD60 to Host1 and Host2 ports.
>>
>> Signed-off-by: Alan Carvalho de Assis <acassis@gmail.com>
>> ---
>>  arch/arm/mach-mx2/Kconfig                   |    1 +
>>  arch/arm/mach-mx2/mxt_td60.c                |  106
>> +++++++++++++++++++++++++++
>>  arch/arm/plat-mxc/include/mach/iomux-mx27.h |   14 ++++
>
> Changes to iomux-mx27.h should go in an extra patch, I think.
>

Yes, I agree.

> [...]
>
>> +static int isp1105_init(struct otg_transceiver *otg)
>> +{
>> +	mxc_gpio_mode(GPIO_PORTB | 23 | GPIO_GPIO | GPIO_OUT);
>> +	gpio_set_value(GPIO_PORTB + 23, 1);
>> +	mxc_gpio_mode(GPIO_PORTC | 31 | GPIO_GPIO | GPIO_OUT);
>> +	gpio_set_value(GPIO_PORTC + 31, 1);
>> +	return 0;
>> +}
>
> gpio_request() is needed here.
>

Sure, I missed it.

> Ideally, you would make that a more generic driver of its own, which lives
> in
> drivers/usb/otg/ and is named something like 'transceiver-gpio'. You would
> instanciate it by passing a platform data struct to set the gpios you want
> it
> to use. This might sound overdone, but it would make your code reusable.
>
> The calls to mxc_gpio_mode() would remain in your platform code, of course.
>

Ok, I need your support here. I'm using mxc-master and I looked for
something related to "transceiver gpio", but no success. I found some
gpio related to usb gadget, but this is not the case. Could you point
me to right function?

Thank you very much,

Alan

> Daniel
>
>

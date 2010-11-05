From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 6 Nov 2010 02:59:02 +0800
Subject: Single binary kernel for all i.MX
In-Reply-To: <20101105123144.GW6017@pengutronix.de>
References: <20101105121800.GV6017@pengutronix.de>
	<20101105122946.GH13530@tarshish>
	<20101105123144.GW6017@pengutronix.de>
Message-ID: <AANLkTikKemXjQYZ9axTP-60bu9xjGrmPE9imf+EDB-p_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 5, 2010 at 8:31 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Nov 05, 2010 at 02:29:46PM +0200, Baruch Siach wrote:
>> Hi Sascha,
>>
>> On Fri, Nov 05, 2010 at 01:18:00PM +0100, Sascha Hauer wrote:
>> > We are talking about a single kernel for longer now, here is something
>> > to test for the ones interested:
>> >
>> > git://git.pengutronix.de/git/imx/linux-2.6.git imx-single-kernel
>> >
>> > Compiling the imx_defconfig will result in a kernel which works
>> > i.MX21, i.MX27, i.MX31, i.MX35 and i.MX51 (not tested on i.MX21).
>> > i.MX1 does not work mainly because the kernel build will use some ARMv5
>> > and later instructions.
>>
>> What is blocking i.MX25 from being included?
>
> It is. I just forgot to mention.

Hrm... the imx series is placing all header files in
arch/arm/plat-mxc/include/plat
instead of within each mach-*. Most other sub-arch doesn't behave like that at
this moment and getting them built together ain't easy.

BTW, did you get it tested on different boards, I'd be interested to see what
could be the potential issues at run-time.

>
> Sascha
>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

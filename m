From: sandeen@sandeen.net (Eric Sandeen)
Date: Fri, 13 Nov 2009 09:42:07 -0600
Subject: [PATCH] arm: Iomega ix4-200d support
In-Reply-To: <20091113085107.GJ13296@deprecation.cyrius.com>
References: <4AFCF6FE.1010603@redhat.com>
	<20091113085107.GJ13296@deprecation.cyrius.com>
Message-ID: <4AFD7E4F.5040909@sandeen.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Michlmayr wrote:
> * Eric Sandeen <sandeen@redhat.com> [2009-11-13 00:04]:
>> +config MACH_IX4_88F6281_NAS
>> +	bool "Iomega ix4-200d NAS"
> 
> If you look at Kconfig, you'll see that putting the CPU id in the MACH
> name is quite unusual for NAS devices (it's only used for dev boards).
> I'd make this IX4200D or NASIX400D.

Ok

> Also, the Kconfig entry should be at the end and not in the middle of
> some reference boards.

ok, not sure how it ended up there ;)

>> --- /dev/null
>> +++ b/arch/arm/mach-kirkwood/ix4-88f6281-setup.c
> 
> nasix4200d.c or ix4200d.c
> 
>> +/*
>> + * Marvell RD-88F6281 Reference Board Setup
> 
> That's obviously copy&paste...
> 
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
> 
> You should add your Copyright.  And probably the Copyright of the file
> on which yours is baed.

I'll have to find it :)

>> +
>> +/* #ifdef IX4_BOARD MV_BOARD_INFO db88f6281AInfo db88f6281AInfoBoardMacInfo */
> 
> What's that?

sorry, leftovers ...

>> +MACHINE_START(NASIX4200D, "Iomega NAS ix4-200d")
>> +	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
> 
> That should be you.

:)  aye.

Argh, sorry, should have read this better before I sent it, it was a 
quick hack - will clean this all up & resend.

>> --- a/arch/arm/tools/mach-types
>> +++ b/arch/arm/tools/mach-types
>> @@ -2132,6 +2132,7 @@ apollo			MACH_APOLLO		APOLLO			2141
>> at91cap9stk		MACH_AT91CAP9STK	AT91CAP9STK		2142
>> spc300			MACH_SPC300		SPC300			2143
>> eko			MACH_EKO		EKO			2144
>> +nasix4200d		MACH_IX4_88F6281_NAS	NASIX4200D		2145
> 
> That's a big no.  First of all, you have to register your own machine
> ID at http://www.arm.linux.org.uk/developer/machines/  Second, when
> you submit a patch, don't include mach-types since this is
> auto-generated.

OK

> Finally, a question: it seems that the buttons and LEDs are not
> supported by your patch.  Do you know how they are hooked up?

I can try to find out.

> Thanks for working on this

Sure, sorry it's such a mess on the first pass, thanks for the review.  :)

-Eric

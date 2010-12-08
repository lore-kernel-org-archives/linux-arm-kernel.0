From: charu@ti.com (Varadarajan, Charulatha)
Date: Wed, 8 Dec 2010 09:52:39 +0530
Subject: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for multi-omap
	for 7xx/15xx/16xx
In-Reply-To: <20101207232315.GE17435@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<20101201183357.GI17222@atomide.com>
	<87zkso4hu3.fsf@deeprootsystems.com>
	<AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
	<20101204212554.GM17222@atomide.com>
	<20101207232315.GE17435@atomide.com>
Message-ID: <AANLkTi=9yHGJf6s0O+ZjYDrrQ6rKqzJJdSvRZ=-911J9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Wed, Dec 8, 2010 at 04:53, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [101204 13:16]:
>> * Varadarajan, Charulatha <charu@ti.com> [101202 06:08]:
>> > On Thu, Dec 2, 2010 at 15:28, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> >
>> > >
>> > > Tony, you can also add
>> > >
>> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> OK, updated. Also made one more GPIO patch to allow us to deal
>> with the 7xx vs 15xx/16xx MPUIO registers.


Thanks for this patch which uses bank stride for OMAP1 MPUIO GPIO.
This would be very helpful while doing GPIO driver cleanup.

Thanks,
V Charulatha

>
> Turns out that broke drivers/mtd/nand/ams-delta.c as it directly uses
> multiple lines in parallel. So let's use 15xx/16xx offsets instead
> and divide them by two.
>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren <tony@atomide.com>
> Date: Sat, 4 Dec 2010 12:39:43 -0800
> Subject: [PATCH] omap1: Fix gpio mpuio bank to work for multi-omap for 7xx/15xx/16xx
>
> We need to divide the 15xx/16xx offset by 2 for 7xx. Use bank->stride
> for that. This allows us to get rid of the duplicate defines for the
> MPUIO registers.
>
> Note that this will cause omap-keypad.c driver to not work on 7xx.
> However, the right fix there is to move over to gpio-keys instead as
> suggested by Cory Maccarrone <darkstar6262@gmail.com> and
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.
>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>

<<snip>>

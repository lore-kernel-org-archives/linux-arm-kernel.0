From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Sep 2010 21:30:53 +0200
Subject: [PATCH 2/3] plat-nomadik: Added suspend/resume support for MTU
	timer.
In-Reply-To: <20100902160443.GR26319@n2100.arm.linux.org.uk>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
	<20100902160443.GR26319@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikTuuVGnOstk+YGq3R9pwrMT-qwkbo7CXMJ4NB6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Sep 02, 2010 at 09:30:32AM +0200, Jonas Aaberg wrote:
>> (...)
>> ? ? ? /*
>> - ? ? ?* Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
>> + ? ? ?* Tick rate is 2.4MHz for Nomadik and 100 or 133MHz for ux500:
>> ? ? ? ?* use a divide-by-16 counter if it's more than 16MHz
>> ? ? ? ?*/
>> - ? ? cr = MTU_CRn_32BITS;;
>> ? ? ? rate = clk_get_rate(clk0);
>> - ? ? if (rate > 16 << 20) {
>> + ? ? if (rate > (16 << 20))
>
> n << 20 doesn't give you MHz, so this code doesn't match the comments.
> Do you mean 16MHz or 16.777216MHz ?

That comes from Alessandros oneshot mode a while back actually,
Jonas is only factoring it around.

Alessandro why do we kick in a prescaler if rate > (16 << 20)?
Seems weird to me too when I look@it, more like it'd be
if rate (1 << 20) which makes sense, if the counter will flip
around 20 bits in 1 second we prescale it by 16.

Yours,
Linus Walleij

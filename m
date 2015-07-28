From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 28 Jul 2015 16:57:52 +0200 (CEST)
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <20150728125500.GB2564@lukather>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
 <55B5E6DB.8020009@redhat.com>
 <20150727120918.191F76C82FB4@dd34104.kasserver.com>
 <55B62768.6040403@redhat.com>
 <20150728090209.1D7BC6C80542@dd34104.kasserver.com><20150728125500.GB2564@lukather>
Message-ID: <20150728145752.43F676C81B65@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Maxime Ripard schrieb am 28.07.2015 14:55:
>> > I plan to submit this for 4.3.
>>
>> Ok, then I guess we can drop my patch.
> 
> Please don't.

Ok.

> It was used in mainline, and reverted because it was not stable
> enough.

Well, the explanation given was, it was not stable because of the missing
regulator support. I don't know whether anyboady actually ever reported
it wouldn't run fine at 1008MHz with 1.45V. So the actual point should be
whether we wan't voltages that are out of the specified range in the
official kernel. The consensus seems to be no, with good reasons for that.
So, I won't object this.

> There's a lot of things we do differently in mainline, it's one of
> them. If someone can provide an OPP for 1008MHz that is stable for all
> the boards and within the operating limits of the SoC, I'd be totally
> fine with that, but we didn't find it so far.
> 
>> For those who don't want to use that setting, it's easier to
>> limit the maximum in userspace compared to compiling a new device
>> tree blob.
> 
> Except that the kernel should not rely on the userspace to be stable
> and harmless for the hardware. It should just work reliably by itself.

Same as above.

Regards,

Timo

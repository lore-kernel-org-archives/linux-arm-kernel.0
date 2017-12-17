From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 17 Dec 2017 21:02:45 +0100
Subject: [PATCH] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
In-Reply-To: <20171212232405.GG10595@n2100.armlinux.org.uk> (Russell King's
 message of "Tue, 12 Dec 2017 23:24:05 +0000")
References: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
 <874lovg095.fsf@belgarion.home>
 <20171212232405.GG10595@n2100.armlinux.org.uk>
Message-ID: <87bmixdswq.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Tue, Dec 12, 2017 at 09:27:34PM +0100, Robert Jarzmik wrote:
>> Russell King <rmk+kernel@armlinux.org.uk> writes:
>> 
>> > Add a gpio driver for the lubbock miscellaneous write IO register so we
>> > can take advantage of subsystems modelled around gpiolib, rather than
>> > having to provide platform specific callbacks.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> 
>> Hi Russell and Linux,
>> 
>> It looks certainly good to me. It's unfortunate in the current status of
>> linux-next I have, gpio-reg.c seems broken (that one is for Linus in [1] and
>> [2]), and therefore I can't test it live.
>
> It won't do much on its own without some patches to make use of the new
> GPIOs... but it will be used as the direct register write becomes a
> call to gpio-reg's ->set_multiple() method.

Applied to pxa/for-next, thanks.

Cheers.

-- 
Robert

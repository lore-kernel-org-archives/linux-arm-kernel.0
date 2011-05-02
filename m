From: davidb@codeaurora.org (David Brown)
Date: Sun, 01 May 2011 21:42:07 -0700
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110429221554.GD14871@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 29 Apr 2011 23:15:54 +0100")
References: <201104212129.17013.arnd@arndb.de>
	<20110429075958.GV17290@n2100.arm.linux.org.uk>
	<20110429093209.1926c732@jbarnes-desktop>
	<201104292029.50680.arnd@arndb.de>
	<20110429221554.GD14871@n2100.arm.linux.org.uk>
Message-ID: <8yapqo1ogrk.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29 2011, Russell King - ARM Linux wrote:

> On Fri, Apr 29, 2011 at 08:29:50PM +0200, Arnd Bergmann wrote:

>> I'd like to first have an official confirmation from the CPU designers
>> if there is actually a problem with mapping a single page both cacheable
>> and noncacheable.
>
> Everytime this gets discussed, someone says that because they don't
> believe what I say.  OMAP folk confirmed it last time around.

I'll confirm this from the Qualcomm side as well.  You cannot have
multiple inconsistent mappings of the same page without having difficult
to find problems.

The spec clarifications appear to give ways of dealing with it if it
happens, and bounds on what can go wrong, but I wouldn't call it
something we want to do normally.  Corrupt data is arguably less of a
problem than nasal demons, but still a problem.

David

> I'm getting tired of this.  I'm going to give up with answering any
> further Linux questions until next week and I'll delete my entire
> mailbox this weekend as I really can't be bothered to catch up with all
> the crap that's happened over easter.  I'm really getting pissed off at
> all the shite crap that's flying around at the moment that I'm really
> starting to not care one ounce about Linux, either on ARM or on this
> utterly shite and broken x86 hardware.
>
> Let ARM rot in mainline.  I really don't care anymore.
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

From: eric@anholt.net (Eric Anholt)
Date: Tue, 15 Aug 2017 11:04:01 -0700
Subject: [PATCH] ARM: bcm2836: Send event when onlining other cores
In-Reply-To: <399697756.271804.1502736043014@email.1und1.de>
References: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
 <1502190295-53391-2-git-send-email-phil@raspberrypi.org>
 <fdecf317-d20b-1a5d-046f-56ef40c55d82@gmail.com>
 <1168905996.270506.1502730695418@email.1und1.de>
 <399697756.271804.1502736043014@email.1und1.de>
Message-ID: <878tikhfn2.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Stefan Wahren <stefan.wahren@i2se.com> hat am 14. August 2017 um 19:11 geschrieben:
>> 
>> 
>> Hi Florian,
>> 
>> > Florian Fainelli <f.fainelli@gmail.com> hat am 14. August 2017 um 18:25 geschrieben:
>> > 
>> > 
>> > 
>> > 
>> > On 08/08/2017 04:04 AM, Phil Elwell wrote:
>> > > Secondary cores should enter a low-power idle state when waiting to
>> > > be started. The "wfe" instruction causes a core to wait until an event
>> > > or interrupt arrives before continuing to the next instruction, and
>> > > the "sev" instruction sends a wakeup event to the other cores.
>> > > 
>> > > Add an "sev" (and a memory barrier) to bcm2836_boot_secondary, the
>> > > function that wakes the waiting cores during booting. This is required
>> > > if the secondary cores are sitting in "wfe", and harmless if not.
>> > 
>> > Eric, should I just pick this up for the upcoming ARM SoC pull requests
>> > that I am preparing, or do you have more changes aside from the two tags
>> > I already merged?
>> 
>> this patch depends on series "ARM: bcm2836: Move SMP startup code to arch/arm".
>> 
>> I didn't had the time to test Phil's patch in all relevant cases. But i could at least prepare a branch with my changes with the acks.
>
> i prepared the branches bcm2835-dt-next-v2 and bcm2835-soc-next.

bcm2835-soc-next on its own breaks boot for me on the Pi2, so I had to
merge in the DT branch first.  I've rebased to do that, pulled in this
patch (and the clk one), and sent PRs for -dt and -soc.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/79544c84/attachment.sig>

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 08 Sep 2012 11:41:45 -0600
Subject: [PATCH V2] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <504B3BED.9080204@simon.arlott.org.uk>
References: <1347083284-17799-1-git-send-email-swarren@wwwdotorg.org>
 <504B3BED.9080204@simon.arlott.org.uk>
Message-ID: <504B8359.80403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2012 06:37 AM, Simon Arlott wrote:
> On 08/09/12 06:48, Stephen Warren wrote:
>> +void __init bcm2708_init_irq(void)
>> +{
>> +}
> ...
>> +static void __init bcm2708_timer_init(void)
>> +{
>> +}
> 
> There's no timer and no interrupt handler so it won't even finish
> booting. It's going to stall when it tries to calculate loops per jiffy.

Yes, I did mention this when I posted V1. Perhaps it's worth mentioning
in the commit description itself too.

> I don't know what you're trying to achieve. This does not add support
> for the BCM2708.

I'm trying to get upstreaming started, a little bit at a time. Right
now, all work has been done outside the regular Linux ARM community. I
feel it'd be much better to start feeding the work upstream. This will
provide much better exposure for the work, and put it into a place
that's more obvious for users, and useful for distros.

Obviously, the next step after this patch is to upstream the interrupt
controller and timer, to resolve the problem mentioned above. There's
certainly still much more to do after that.

> See https://github.com/lp0/linux/commits/rpi-split from June 21 onwards
> for separate patch commits that apply to specific devices.
> 
> On 08/09/12 06:48, Stephen Warren wrote:
>> v2:
>> * Rename *_BASE to *_PHYS to match Simon's rpi-split branch.
> 
> You've definitely used the rpi-linear branch if you're missing things.
> The HEAD of the two branches is identical but rpi-split has a rebased
> history.

No, I just took the HEAD of the branch, and manually copied minimal
pieces out of it to create this patch; the interim contents of any of
the patches in the branches didn't influence this patch at all.

BTW, could you possibly fix your git configuration so that your commits
have a valid email address in the git author field and Signed-off-by
tag? For this patch, I set the git author field to myself even though
you (and others) authored the work it was derived from, since I didn't
feel comfortable using the invalid values from your git repo.

Thanks for the interest in these patches!

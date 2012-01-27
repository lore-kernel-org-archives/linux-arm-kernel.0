From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 27 Jan 2012 10:43:18 +0100
Subject: at91: pm.h cleanup
In-Reply-To: <20120126233414.GF11941@n2100.arm.linux.org.uk>
References: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
 <4F217CCD.5000104@atmel.com> <20120126203350.GD11941@n2100.arm.linux.org.uk>
 <20120126233414.GF11941@n2100.arm.linux.org.uk>
Message-ID: <4F2271B6.9070006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2012 12:34 AM, Russell King - ARM Linux :
> On Thu, Jan 26, 2012 at 08:33:50PM +0000, Russell King - ARM Linux wrote:
>> On Thu, Jan 26, 2012 at 05:18:21PM +0100, Nicolas Ferre wrote:
>>> Daniel,
>>>
>>> I have rebased your patch series on top of:
>>>
>>> - at91 late device/board patches that are planned for 3.3
>>> - at91-fixes branch (should go also in 3.3)
>>> * rmk/for-next branch (with a merge conflict resolved)
>>> * the removal of CAP9 SoC family
>>>
>>> You can find the resulting code in our git tree:
>>>
>>> git://github.com/at91linux/linux-at91.git at91-pm_cleanup
>>>
>>> I hope that I will be able to send this branch to arm-soc soon with a
>>> minimum of future rebase (when the two first series cited above will be
>>> in Linus' tree actually).
>>
>> No you won't, not if you're including rmk/for-next in it.
>>
>> Take a moment to think about that: rmk/for-next is NOT a topic branch.
>> It is purely a branch published for the sake of SFR.  It gets torn down
>> and regenerated regularly.  You can't base work off it.  It's all explained
>> here:
>>
>> 	http://www.arm.linux.org.uk/developer/git-arm.php
> 
> As a follow-up to this, your action has put in jeopardy two things:
> 
> 1. The ability for me to publish patches in my git tree for people to be
>    able to test large patch sets.
> 
> 2. The ability to publish patches which are ready for mainline but have
>    not yet had all the acks etc received.
> 
> The official position on the publication of git commits is that once
> they're published, they can't be changed - with the exception of the
> linux-next tree.
> 
> What that means is that if I followed that rule, I would not publish very
> many changes until the last minute for the simple reason that people in
> the ARM community absolutely suck to the back teeth giving acks and so
> forth to large patch sets.  Example: had I followed that guidance, the
> restart changes would not have gone in during the last merge window.
> 
> So, either *EVERYONE* understands how I run my tree and they DO NOT
> EVER include any branch into their own tree without FIRST TALKING TO
> ME, or I withdraw my tree from public access.  It's that simple.  It's
> not something ANYONE can make a mistake over.  You make a mistake and
> it causes BIG PROBLEMS.
> 
> SFR _has_ noticed and _is_ complaining about this.  It's only time
> before it gets noticed elsewhere.
> 
> So, I've withdrawn the highly unstable devel-3.3 branch from public
> view as of NOW.  I'm going to remove anything in for-next which isn't
> 100% ready.  That includes the mach-types update, because I intend
> to redo it at some later time.
> 
> Congratulations.  And thanks for causing this situation through your
> lack of due dilligence.

Russell,

So many problems on my shoulders!

I was just trying to anticipate the git branch that you are putting in
place for 3.4 development (your have now published one with "for-armsoc"
if I am following correctly the plans).

I was mentioning in my email that this at91-pm_cleanup branch may be
rebased and I *never* thought of making a pull request out of it.

My mistake was to push it to our at91-next which ends up being included
in linux-next. Yes it was dumb and I will ask Stephen to remove the
at91-next branch from his pull list.
AT91 will rely on arm-soc to get exposure in linux-next which is simpler
and less prone to errors.

Best regards,
-- 
Nicolas Ferre

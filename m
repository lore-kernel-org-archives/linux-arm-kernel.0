From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 May 2012 23:23:11 -0700
Subject: [GIT PULL] ep93xx cleanups for 3.5
In-Reply-To: <4FACAFB9.7000506@gmail.com>
References: <4FAC6389.40607@gmail.com>
 <CAOesGMiPiYF8d2x5hHBChvTkaGJPGVKZR=wyumhbk1BV=t4eiA@mail.gmail.com>
 <4FACAFB9.7000506@gmail.com>
Message-ID: <CAOesGMg2RctVcMUaVz07biWBN_oswA_ROQ63o=D5h8ZzyOeVGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 11:20 PM, Ryan Mallon <rmallon@gmail.com> wrote:
> On 11/05/12 16:18, Olof Johansson wrote:
>
>> Hi,
>>
>> On Thu, May 10, 2012 at 5:55 PM, Ryan Mallon <rmallon@gmail.com> wrote:
>>> The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:
>>>
>>> ?Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)
>>>
>>> are available in the git repository at:
>>>
>>> ?git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-cleanup-for-3.5
>>>
>>> for you to fetch changes up to a1eacd79a602707f97201edbac9a03edaaea1847:
>>>
>>> ?arm: ep93xx: use gpio_led_register_device (2012-04-12 09:38:15 +1000)
>>>
>>> ----------------------------------------------------------------
>>> H Hartley Sweeten (2):
>>> ? ? ?arm: ep93xx: use DEFINE_RES_* macros
>>> ? ? ?arm: ep93xx: use gpio_led_register_device
>>>
>>> Ryan Mallon (1):
>>> ? ? ?Fix build breakage in ep93xx-core
>>
>> Pulled, thanks.
>>
>> One^WTwo nits: please use the format 'ARM: ep93xx: <...>' on these
>> kind of commits in the future. Also, since you have the commit that
>> introduces the error right before, you can squash it in with the
>> bugfix (and document it in the signed-off-by sequence if you prefer --
>> see SubmittingPatches for examples).
>
>
> Thanks,
>
> The reason I didn't squash the patches together was that I had already
> pushed the original broken commit out. I'm still a bit unclear on how to
> fix things on a public stable branch once it has been pushed.
>
> I'll make sure that all patches have the correct subject headers in future.

Ah yes, if you have a stable branch that makes it hard.

Sometimes it helps to have two branches, one stable and one unstable,
both merged into a for-next branch that goes into Stephen's
linux-next. That way you can have a patch sit there a little while to
catch errors like these before you move them over to the stable base.

Either way, not a big deal unless we end up with a large number of
these kind of fixes, one or two here or there is fine.


-Olof

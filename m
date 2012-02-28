From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 28 Feb 2012 17:33:18 -0600
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <CAJOA=zPpptmXFKpmgA_bT+jCr2hv5tfW+xaPnocc6oXk=cpidw@mail.gmail.com>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
 <CAJOA=zNZ2xh34DTZc1gJwy0O6d=E=wdP4_sq_zrj3qjLcbj0kw@mail.gmail.com>
 <CAMXH7KFbH2HFwFgMu+XfrFKSEGTvD_H09EN2atHUJa9pz7ESYg@mail.gmail.com>
 <CAJOA=zPpptmXFKpmgA_bT+jCr2hv5tfW+xaPnocc6oXk=cpidw@mail.gmail.com>
Message-ID: <CAMXH7KFz18Wv=RYvbww3OqBspbP3L0UqLmuiJ7q8c6vyYv2b2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> I brought this topic up internally and Jon suggested that the 'usage'
> statistics that are reported in sysfs should also reflect failed
> versus successful C-state transitions, which is a great idea. ?This
> could simply be achieved by renaming the current 'usage' count to
> something like 'transitions_attempted' and then conditionally
> increment a new counter within the 'if (entered_state >= 0)' block,
> perhaps named, 'transition_succeeded'.
>
> This way the old 'usage' count paradigm is as accurate as the new
> time-keeping code. ?Being able to easily observe which C-state tend to
> fail the most would be invaluable in tuning idle policy for maximum
> effectiveness.
>
> Thoughts?

Sounds reasonable.  In some cases it may be helpful to track state
demotion as well.  Since I'm still a noob and wearing my submission
training wheels, I'm trying to minimize things that fall outside of
this basic consolidation effort for this patch series.  But I added
Jon's suggestion to this cpuidle page which contains future cpuidle
items to consider adding:
https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/CPUIdle#Track_both_attempted_and_successful_enter_attempts

>
> Regards,
> Mike
>
>>
>>>
>>> Regards,
>>> Mike

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Mar 2014 15:45:34 +0530
Subject: [RFC v3 0/5] cpufreq:LAB: Support for LAB governor.
In-Reply-To: <20140324110032.7aeae15e@amdc2363>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
 <CAKohpok1zBsX7n70r=geCOaP-9ONx2QdaUMK6cJeqhFrO1PkUg@mail.gmail.com>
 <20140324110032.7aeae15e@amdc2363>
Message-ID: <CAKohpo=6F_d3WF6TuNODDhhig5oDjC2dhAjqXp4E+c6VJyCiFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Linaro lists in cc as there are few people here working on power/thermal
stuff.]

On 24 March 2014 15:30, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> On 4 March 2014 15:57, Lukasz Majewski <l.majewski@samsung.com> wrote:

> I think, that "LAB" name is with us for some time, so it would be a
> pity to discard it.

It doesn't matter with Mainline how you do naming initially for your code :)
We need to pick the right name now, and the decision should be made
now (after discussions obviously) :)

>> What about making it as simple as:
>> - changing the ondemand governor only instead of adding a new governor
>
> My goal is to not touch the ondemand code. It has matured, so I would
> like to leave it as it is.

Because the boost feature is already part of CPUFreq core, I think its
better if we enhance current governors to use it. So, I would like to
make this part of existing governors. Not only ondemand but maybe
conservative as well..

Also, I feel we maynot necessarily move this piece of code into cpufreq.
All you are doing is thermal management here :)

If we are sure we will not burn out our SoC (When many cores are idle),
run at max freq (if there is enough load of course :))..

And if there are chances that we might burn our chip (when very few
cores are idle), don't run on boost frequencies..

This is actually a 'cooling' device :)

Think of it this way: CPUFreq will provide a range of frequency which
SoC's can use. And then based on some conditions we may or may not
want to run on these frequencies.

@Zhang/Eduardo: Can we have your inputs here as well ?

This may look hard but we need to design things in the best possible
way for managing things better in future. Lets see what others have
to say on this.

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 19:24:54 +0530
Subject: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
In-Reply-To: <CAJuA9agfoVwqa88=JB+SirjcO0dXy0s0fTc8=dP=u7H8uarSyg@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
 <1400029380-5372-2-git-send-email-thomas.ab@samsung.com>
 <CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
 <CAJuA9agfoVwqa88=JB+SirjcO0dXy0s0fTc8=dP=u7H8uarSyg@mail.gmail.com>
Message-ID: <CAKohpon-z-MS68qkEvioBPLVvoieo0WqGBTC+ZJz+KsoZ8CGhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 19:16, Thomas Abraham <ta.omasab@gmail.com> wrote:
> On Wed, May 14, 2014 at 9:10 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> Why is this present outside of above if {} ? as boost_freqs is guaranteed to
>> be NULL without that.
>
> Just to reduce indentation by one tab. No technical reasons. The code
> had to wrap at 80 column was becoming unreadable.

That's bad :), you have added an extra comparison just for that :(
Instead kill the below indentation by doing a "goto out" with a ! of
below expression:

>> +       if (of_find_property(dev->of_node, "boost-frequency", &len)) {

From: nm@ti.com (Nishanth Menon)
Date: Wed, 14 May 2014 09:31:49 -0500
Subject: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
In-Reply-To: <CAKohponG9PNse4cHkvfLfaRouW-jxjToBXUCHyOCgx8-Pc=2Xw@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>	<1400029380-5372-2-git-send-email-thomas.ab@samsung.com>	<CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>	<CAGo_u6p-uqw82ewDciDEhAt0=Nswfw33-gf8Aa+-6_k3eCcTzw@mail.gmail.com>	<20140514080930.781e0557@amdc2363>
 <CAKohponG9PNse4cHkvfLfaRouW-jxjToBXUCHyOCgx8-Pc=2Xw@mail.gmail.com>
Message-ID: <53737E55.9070704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 01:24 AM, Viresh Kumar wrote:
> On 14 May 2014 11:39, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> I agree with Nishanth here, that point 1 (as described by Viresh at
>> [*]) is a more scalable approach.
> 
> The only reason why I wanted all that to be done at OPP level was to
> ensure if somebody else also needs it apart from cpufreq, they don't have
> to duplicate code and find it.. As it is present at a central place..
> 
> But if no other code is going to look for that, it may just be fine as is..
> 
If we eventually have a need beyond cpufreq (say devfreq) with similar
instances, then it makes sense to move it out to a generic place.
Either way, code implementation/duplication is a OS problem - and
should be looked at independent of the description in dts. If we feel
the description is valid hardware description (which, personally, I
do), then lets go to the next discussion point of where to put it -
generic or cpufreq specific (here, I have no preference), and finally
decide the implementation as necessary as a result of the description.

-- 
Regards,
Nishanth Menon

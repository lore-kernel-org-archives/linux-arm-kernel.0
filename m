From: ccross@android.com (Colin Cross)
Date: Thu, 2 Jun 2011 23:16:52 -0700
Subject: [GIT PULL] scalable TWD localtimer
In-Reply-To: <4DE87085.1090901@ti.com>
References: <BANLkTik0TVpfax1Fe8c_6A9SFUNzfDbxyw@mail.gmail.com>
	<4DE87085.1090901@ti.com>
Message-ID: <BANLkTikYRk6ZKaZnTt4NFiDSnbN+jyNT-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2011 at 10:26 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Linus,
>
> On 6/3/2011 3:31 AM, Linus Walleij wrote:
>>
>> Hi Russell,
>>
>> please consider pulling this for the -rc series since I see this as a
>> horrible bug that Thomas just fixed the infrastructure to properly
>> counter the week before the merge window.
>>
>> You probably know the story but basically there is one clockline
>> into the ARM-supplied MPCore thing, and it inevitably also clocks
>> the TWD. Sadly that includes the localtimer, which will make all
>> clockevents scale in both directions, firing too late or too early
>> as compared to desired wall-clock time (or system clocksource) as
>> the clock speed of the core is changed. Right now there is no
>> compensation whatsoever for this so to run the system reliably
>> on v3.0-rc1, cpufreq has to be disabled.
>>
>> Thomas and Colin did the grunt work, I added a scaling smp_twd
>> clock reflecting the Ux500 cpufreq changes, and now it is rock solid
>> as far as I can tell.
>>
> Hope the pull is already not done. If not I would like to submit the
> OMAP clock change as well along with this series and may be Colin might
> want to do the same for Tegra.
>
> Regards
> Santosh
>
>

I will submit the Tegra clock change along with a separate series.
This change should not change any functionality on platforms where the
clock has not been defined, so there is no need to sequence it with
clock patches.

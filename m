From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 03 Jun 2011 10:56:29 +0530
Subject: [GIT PULL] scalable TWD localtimer
In-Reply-To: <BANLkTik0TVpfax1Fe8c_6A9SFUNzfDbxyw@mail.gmail.com>
References: <BANLkTik0TVpfax1Fe8c_6A9SFUNzfDbxyw@mail.gmail.com>
Message-ID: <4DE87085.1090901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 6/3/2011 3:31 AM, Linus Walleij wrote:
> Hi Russell,
>
> please consider pulling this for the -rc series since I see this as a
> horrible bug that Thomas just fixed the infrastructure to properly
> counter the week before the merge window.
>
> You probably know the story but basically there is one clockline
> into the ARM-supplied MPCore thing, and it inevitably also clocks
> the TWD. Sadly that includes the localtimer, which will make all
> clockevents scale in both directions, firing too late or too early
> as compared to desired wall-clock time (or system clocksource) as
> the clock speed of the core is changed. Right now there is no
> compensation whatsoever for this so to run the system reliably
> on v3.0-rc1, cpufreq has to be disabled.
>
> Thomas and Colin did the grunt work, I added a scaling smp_twd
> clock reflecting the Ux500 cpufreq changes, and now it is rock solid
> as far as I can tell.
>
Hope the pull is already not done. If not I would like to submit the
OMAP clock change as well along with this series and may be Colin might
want to do the same for Tegra.

Regards
Santosh

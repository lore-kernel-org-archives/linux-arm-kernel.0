From: olof@lixom.net (Olof Johansson)
Date: Mon, 23 Jan 2012 00:09:42 -0800
Subject: possible hrtimer related problem on tegra
In-Reply-To: <1539302.lfXQIS47Lr@ax5200p>
References: <1539302.lfXQIS47Lr@ax5200p>
Message-ID: <CAOesGMhaXjxzoz-OWF3V0HsdWzuxRJMaE-MSjdAFwN8+KgQLBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 22, 2012 at 7:18 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Hi,
>
> I've been plagued with random lockups starting with Linux 3.0.13 (pulled from
> ChromeOS-3.0 tree) on a Tegra board (paz00). First symtoms are slowly losing
> responsiveness followed by a total lockup (nothing in dmesg, no oops). Using
> performance governor instead of ondemand, made it go away.
>
> So I started bisecting 3.0.12..3.0.13 and finially found that reverting
> 24ee8bfe (hrtimer: Fix extra wakeups from __remove_hrtimer()) fixes the
> problem.
>
> As Olof mentioned on IRC it is likely that the patch does not directly causes
> lockups but something else which was hidden before. It isn't clear to me if
> other tegra boards (seaboard, harmony) also suffer from this.
>
> Any hints on this issue are appreciated.

You're asking on a community list about issues with a distro kernel.
In general that is frowned upon.

Since I'm one of the people looking after the distro kernel in
particular though; The current 3.0 tegra branch has a handful of
stability issues with power management/cpufreq/dvfs enabled, and we
have chosen to (at least for now) disable those features in our
configs. Chances are good that that patch in question is tickling a
bug that is specific to the Chrome OS tree so without further
investigation I don't see a reason to pull in external folks right now
either.

The other tegra maintainers don't particularly know what's in our
distro tree either, and I wouldn't expect them to spend time on
working on out-of-tree code that isn't their own.

Best way forward is probably for you to do a local revert on the
offending patch and to open a new issue at http://crosbug.com/ for it.
Feel free to cc me (olofj at chromium.org) on the bug.


-Olof

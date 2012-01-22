From: marvin24@gmx.de (Marc Dietrich)
Date: Sun, 22 Jan 2012 16:18:12 +0100
Subject: possible hrtimer related problem on tegra
Message-ID: <1539302.lfXQIS47Lr@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been plagued with random lockups starting with Linux 3.0.13 (pulled from 
ChromeOS-3.0 tree) on a Tegra board (paz00). First symtoms are slowly losing 
responsiveness followed by a total lockup (nothing in dmesg, no oops). Using 
performance governor instead of ondemand, made it go away.

So I started bisecting 3.0.12..3.0.13 and finially found that reverting 
24ee8bfe (hrtimer: Fix extra wakeups from __remove_hrtimer()) fixes the 
problem.

As Olof mentioned on IRC it is likely that the patch does not directly causes 
lockups but something else which was hidden before. It isn't clear to me if 
other tegra boards (seaboard, harmony) also suffer from this.

Any hints on this issue are appreciated.

Thanks

Marc

From: marvin24@gmx.de (Marc Dietich)
Date: Thu, 1 Sep 2011 13:13:41 +0200
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <4E5F5FA9.3010305@arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
	<4E5F5FA9.3010305@arm.com>
Message-ID: <201109011313.42547.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Marc,

^dito,

> On 31/08/11 17:55, Marc Dietrich wrote:
> > Am Mittwoch 31 August 2011, 18:12:48 schrieb Marc Zyngier:
> >> [...]
> >> Oddly enough, this patch doesn't do anything on my Tegra setup. In both
> >> cases, I get around 17MB/s from a crap SD card plugged in a USB reader.
> >> 
> >> This leads me to suspect that this issue is very much OMAP4 specific.
> >> Can anyone verify this theory on other some A9 platforms?
> > 
> > That's odd. On my Tegra2 (on ac100) it boosts the transfer rate from 7 to
> > 17 MB/s.
> 
> I'm using a Harmony board. Could you share your kernel version, .config
> and dmesg?
> 
> Thanks,
> 
> 	M.

I use the chromiumos tree (for chromiumos 2.6.38 kernel: 
http://git.chromium.org/chromiumos/third_party/kernel-next.git) with some 
additions to make it run on the AC100. This modified tree is on 
git://gitorious.org/~marvin24/ac100/marvin24s-kernel.git. The config is 
paz00_defconfig and a dmesg you can get e.g. from http://pastebin.com/9uVfDWma
(it's not very current, but it should be sufficient).

I'll add Stephen Warren from NVIDIA to the CC list. He has more HW to test on. 

Btw, this is the patch I used: http://gitorious.org/~marvin24/ac100/marvin24s-
kernel/commit/cce8d9e25d009a45c219a6ad0b9ac4e27d034ab0

	Marc

From: eric@anholt.net (Eric Anholt)
Date: Mon, 18 May 2015 12:43:32 -0700
Subject: Raspberry Pi DT clocks series
Message-ID: <1431978219-14226-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a series to add a real clock provider on Raspberry Pi.
Previously, we've been using a mix of fixed clocks from clk-bcm2835.c
(though some of them failed to get used by their intended consumers),
and fixed-clock nodes in the DT.

This driver gives us the ability to enable/disable our clocks, and
also lets us get and set frequency values.  This will let us build a
cpufreq driver (Andrea Merello has done some work on this front, and
has a couple of options available), and get correct frequencies on the
Raspberry Pi 2 without hardcoding new values.

This branch can be found at:

https://github.com/anholt/linux/tree/rpi-dt-clocks

which also has a patch for the MMC clock which is not included yet due
to a bug in the sdhci driver.  The series applies on top of
rpi-mailbox, whose code is currently out for review:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-May/001762.html

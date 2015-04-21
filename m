From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:47 -0700
Subject: BCM2836 (Raspberry Pi 2) port
Message-ID: <1429639796-2169-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is my first submission of a Raspberry Pi 2 port.  It can be found
at https://github.com/anholt/linux/tree/bcm2836

I'm using the 2835 interrupt controller support, without adding the
checks for ARM local interrupts first.  That means no support for IPIs
(and thus no SMP), no PMU events, and no local timer (I'm using the
same 2835 peripheral one).

It supports a similar featureset to Pi 1 at this point.  Serial and SD
cards work.  Just one CPU supported.  USB (ethernet) works if you use
U-Boot, or my mailbox series
(https://github.com/anholt/linux/tree/bcm2836-mbox).

From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 15:58:55 -0700
Subject: [PATCH 0/4] bcm2835: add thermal driver
In-Reply-To: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87ziruano0.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add thermal driver for the bcm2835 SOC.
>
> Right now this driver does not set up the thermal device
> itself, but relies on the fact that the firmware is setting
> the device up correctly.
>
> Also it is currently only reading from the register-set.
>
> The driver also exposes the registers via debugfs.

I had looked through before and decided that the FW was turning the
tempsens clock on and off at runtime so we'd have to go through it for
checking temperature.  Looking at it now, though, it keeps the clock
running the entire time and just does a read periodically.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/7863f378/attachment.sig>

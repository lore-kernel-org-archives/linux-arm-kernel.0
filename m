From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Jan 2017 20:49:46 +0100
Subject: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
is enabled:

# dmesg | grep ath
[    7.207770] ath10k_pci 0000:02:00.0: Refused to change power state, currently in D3
[    7.237955] ath10k_pci 0000:02:00.0: failed to wake up device : -110
[    7.238146] ath10k_pci: probe of 0000:02:00.0 failed with error -110

if however PCIEASPM is off, the driver probes correctly and the ath10k
adapter works fine.

I wonder if someone has an idea what needs to be done to fix this
problem. (OK, I could disable PCIEASPM, but I'd like to have a solution
for a distribution kernel where I think PCIEASPM=y is sensible in
general.)

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170111/91e57d62/attachment.sig>

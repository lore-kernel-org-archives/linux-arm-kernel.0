From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 17 Jan 2017 09:14:44 -0600
Subject: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
In-Reply-To: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
Message-ID: <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
> ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
> is enabled:
> 
> # dmesg | grep ath
> [    7.207770] ath10k_pci 0000:02:00.0: Refused to change power state, currently in D3
> [    7.237955] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> [    7.238146] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> 
> if however PCIEASPM is off, the driver probes correctly and the ath10k
> adapter works fine.
> 
> I wonder if someone has an idea what needs to be done to fix this
> problem. (OK, I could disable PCIEASPM, but I'd like to have a solution
> for a distribution kernel where I think PCIEASPM=y is sensible in
> general.)

Can somebody confirm that this system (Marvell Armada 385-based Turris
Omnia) does actually support ASPM in hardware?

From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 2 Jun 2010 13:34:18 +0300
Subject: [PATCH 3/3] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <alpine.LFD.2.00.1006011447410.24526@xanadu.home>
References: <1275404968-12258-1-git-send-email-saeed@marvell.com>
	<1275404968-12258-2-git-send-email-saeed@marvell.com>
	<1275404968-12258-3-git-send-email-saeed@marvell.com>
	<alpine.LFD.2.00.1006011447410.24526@xanadu.home>
Message-ID: <AANLkTiltiNe5W0bRyEYIFJK0nB-Y4DDxHvBMHZntChdB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think this looks like a bit too much code for what this does. ?To
> simplify things, you could:
>
> 1) Duplicate kirkwood_pcie_setup() into kirkwood_pcie0_setup() and
> ? kirkwood_pcie1_setup() instead. ?This will remove a couple
> ? "if (pp->index == 0)" and the snprintf() which could remain
> ? purely static initializations.
>
> 2) Remove bus_to_port() entirely, and store the address of the appropriate
> ? struct pcie_port instance into the sysdata pointer of the pci_bus
> ? structure. ?This struct pcie_port could even be kmalloc'd as needed.
The sysdata already used by arm to store the pci_sys_data, I think we
will have to add a private pointer to the pci_sys_data structure, that
pointer will hold mach specific data per pci controller. this pointer
is needed for any platform that has multiple pci controller. agree?

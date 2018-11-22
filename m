From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2018 15:46:51 +0100
Subject: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
In-Reply-To: <20181122154523.5aa652d4@windsurf>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
 <20181122154523.5aa652d4@windsurf>
Message-ID: <20181122154651.223c62d9@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 22 Nov 2018 15:45:23 +0100, Thomas Petazzoni wrote:

> This should be:
> 
> 	if (!IS_ERR(pcie->reset_gpio))
> 
> Indeed, in the case of an error, pcie->reset_gpio will be non-NULL,
> with the error encoded as a ERR_PTR().

Meh, scrap that. If pcie->reset_gpio was an error, probe() has failed.
So by the time we are in armada8k_pcie_host_init(), pcie->reset_gpio is
either NULL or a valid GPIO. So my comment was stupid.

Since the newline thing is way too minor to require a new iteration:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks, and sorry for the noise.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

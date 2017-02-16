From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 14:27:55 +0100
Subject: [PATCH v3 5/6] ARM: mvebu: Add driver for mv98dx3236-soc-id
In-Reply-To: <20170216085041.28337-6-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
 <20170216085041.28337-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <28604982.PnlvXC13kC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 16, 2017 9:50:39 PM CET Chris Packham wrote:
> The DFX server on the 98dx3236 and compatible SoCs has an ID register
> that provides revision information that the PCI based ID register
> doesn't have. Use this if it's available.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 

How about putting this new code into a separate driver in
drivers/soc/? I don't think you need the early probing we have
here, and not that much is shared otherwise.

	Arnd

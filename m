From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Dec 2013 10:12:43 -0700
Subject: [PATCH v4 3/3] ARM: tegra: correct Colibri T20 regulator settings
In-Reply-To: <fc7440a2f4bf9ab95e47a911c0e0b3b6a2250356.1386108712.git.stefan@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
 <fc7440a2f4bf9ab95e47a911c0e0b3b6a2250356.1386108712.git.stefan@agner.ch>
Message-ID: <52A0B40B.7040903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 03:18 PM, Stefan Agner wrote:
> Set the parent of the regulators LDO2 to LDO9 according to the
> schematic. Set the base voltage to 3.3V, there is only 3.3V on the
> module itself.
> 
> Set the Core and CPU voltage to the specified voltages of 1.2V and
> 1.0V respectivly.
> 
> LDO6 should deliver 2.85V. The attached peripherals were not in
> use so far.

Does this depend on patch 1/3 or 2/3, or can I apply it to the Tegra
tree which doesn't include those patches?

If this does depend on patch 1/3 or 2/3... this patch feels a bit big to
apply to the MFD tree. Perhaps patch 1/3 and 2/3 could be applied alone
to a topic branch in the MFD tree so I can merge that into the Tegra
tree in order to apply this?

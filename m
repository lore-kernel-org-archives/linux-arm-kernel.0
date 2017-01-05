From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 4 Jan 2017 20:06:49 -0800
Subject: [PATCHv2 4/5] arm: mvebu: Add device tree for 98DX3236 SoCs
In-Reply-To: <20170105033641.6212-5-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170105033641.6212-5-chris.packham@alliedtelesis.co.nz>
Message-ID: <1ee850ee-f771-1aeb-6b96-dfbe3118f2fc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/04/17 ? 19:36, Chris Packham a ?crit :
> The Marvell 98DX3236, 98DX3336, 98DX4521 and variants are switch ASICs
> with integrated CPUs. They are similar to the Armada XP SoCs but have
> different I/O interfaces.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> +
> +		switch {
> +			packet-processor at 0 {
> +				compatible = "marvell,prestera-98dx4521";
> +			};
> +		};

This may be a bit premature if you are not providing a binding document
for this sub-node, you might as well add it once you also add a
corresponding driver (or if this will remain out of tree, at least
submitting a separate binding document).

Also, if this node's unit address is 0, you would expect at least a reg
property whose address cell is 0 to be present.
-- 
Florian

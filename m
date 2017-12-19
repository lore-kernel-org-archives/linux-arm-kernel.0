From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 19 Dec 2017 18:16:09 +0100 (CET)
Subject: [PATCH] ARM: dts: add minimal device tree for compute model 3
In-Reply-To: <20171124121813.11318-1-kernel@martin.sperl.org>
References: <20171124121813.11318-1-kernel@martin.sperl.org>
Message-ID: <391028930.257226.1513703769801@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 24. November 2017 um 13:18 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add a minimal working device tree for the compute model 3
> for both arm and arm64.
> 

just a note before you send a V2. Recently i looked at the CM datasheet (revision 1.0) and noticed on the block diagram (page 8) that the CM3 eMMC I/O voltage is fixed at 1.8 Volt (doesn't apply to CM3 lite). Providing a fixed regulator for vmmc/vqmmc-supply [1] would give the MMC core the chance to figure out the right voltage.

[1] - http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/mmc/mmc.txt

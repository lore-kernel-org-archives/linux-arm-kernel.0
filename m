From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 Jul 2015 16:18:11 -0600
Subject: [PATCH v3 2/4] staging/nvec: reimplement on top of tegra i2c
 driver
In-Reply-To: <1437424546-30405-3-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-3-git-send-email-danindrey@mail.ru>
Message-ID: <55AD73A3.6000706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 02:35 PM, Andrey Danin wrote:
> Remove i2c controller related code and use tegra i2c driver in slave mode.
> Update nvec documentation.

> diff --git a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt

I would expect this patch to add a new binding file 
nvidia,nvec-slave.txt so that the filename continues to match the 
compatible value it documents. This patch introduces a new binding for 
the NVEC slave as opposed to modifying the existing binding.

> +- compatible : should be "nvidia,nvec-slave".
> +- reg: the i2c address of the slave controller

I think "the I2C address to respond to" would be clearer? You might also 
mention that this needs to include flags from <dt-bindings/i2c/ic2.h>.

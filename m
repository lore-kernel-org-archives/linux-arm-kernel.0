From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Aug 2014 13:33:43 +0100
Subject: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
In-Reply-To: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
References: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
Message-ID: <20140813123343.GR17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:52:39PM +0200, Michal Simek wrote:
> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."

Would it not be better to do this as a tree wide or at least subsystem
wide sweep with something like cocinelle?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/ddd3ef9d/attachment.sig>

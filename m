From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 13:15:43 +0100
Subject: [PATCH] regulator: core: remove sysfs entry properly in
 regulator_put
In-Reply-To: <1341469182-5079-1-git-send-email-shawn.guo@linaro.org>
References: <CAOMZO5BD_FcXVU18PauOFudod5FKd9MP-ZNUDJ4F9iQ6+EAjiA@mail.gmail.com>
 <1341469182-5079-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120705121543.GX4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 02:19:42PM +0800, Shawn Guo wrote:
> With changes introduced by commit 222cc7b (regulator: core: Allow
> multiple requests of a single supply mapping) on create_regulator,
> regulator_put needs a corresponding update on sysfs entry removing.
> 
> Also regulator->dev still needs to get assigned in create_regulator,
> otherwise, sysfs_remove_link call in regulator_put will get bypassed.

Applied, but you should really know better than to submit two separate
changes in a single patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/5a0876c2/attachment.sig>

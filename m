From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 15:44:02 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <201205081436.46471.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <201205081348.14269.arnd@arndb.de>
 <20120508142926.GT15893@opensource.wolfsonmicro.com>
 <201205081436.46471.arnd@arndb.de>
Message-ID: <20120508144401.GU15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 02:36:46PM +0000, Arnd Bergmann wrote:

> Right, which is what the driver has done since 79568b9412 "regulator:
> initialization for ab8500 regulators" with your ack, so we decided not
> to change that and simply move the init data from platform code
> to the device tree.

Yes, I've never seen the arch/arm bit of it before to see what the magic
writes actually do before - I did review the original code which just
used the regulator API normally but not this magic number stuff which
was just done in the platform.  The magic numbers might be OK for things
where it's device specific enough but the comments here make it clear
that some of the magic number setup is duplicating framework features.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/578f5479/attachment.sig>

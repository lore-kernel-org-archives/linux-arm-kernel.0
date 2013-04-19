From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Apr 2013 01:11:44 +0200
Subject: [PATCH v3] ARM: default machine descriptor for multiplatform
In-Reply-To: <5171C397.9090301@gmail.com>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <201304192354.25065.arnd@arndb.de> <5171C397.9090301@gmail.com>
Message-ID: <201304200111.44617.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 April 2013, Rob Herring wrote:
> The only remaining user of of_platform_driver is ibmebus and 2 drivers.
> It would be good to convert those to regular platform drivers.
> 

Right, I would not expect any trouble in converting ibmebus to
use a regular platform_driver. It already uses platform_device
anyway. We cannot remove ibmebus itself because it has special
DMA requirements, but we could move it to drivers/bus if the
powerpc maintainers like that.

	Arnd.

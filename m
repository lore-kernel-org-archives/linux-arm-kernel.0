From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2012 13:49:08 +0000
Subject: [PATCH 00/19] First HREF Device Tree enablement patch-set
In-Reply-To: <CACRpkdbPwiaF8tfEE7NNd_KE3VGtVx-pPwL-HObhh3fRYXqH=g@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <201209101013.16697.arnd@arndb.de>
 <CACRpkdbPwiaF8tfEE7NNd_KE3VGtVx-pPwL-HObhh3fRYXqH=g@mail.gmail.com>
Message-ID: <201209101349.08857.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Linus Walleij wrote:
> > When the driver offers
> > two ways of probing a device, this lets us change from one way to
> > the other without going through a phase where we use neither of them
> > or (worse) both at the same time.
> 
> Maybe unrelated, but as usual it works as long as there are no
> DMA channels or callback functions :-/
> 
> The MMC, PL022 patches in this patch set: both need
> AUXDATA and DT data simultaneously due to DMA channels
> and callbacks passed in as AUXDATA.

Yes, that's another discussion. When this happens, we obviously
keep the platform data (or add a new version of it), but I'd still
use one patch to add the node to the device tree and simultaneously
add the auxdata and remove the static device registration.

	Arnd

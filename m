From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 May 2013 12:15:23 +0100
Subject: [PATCH v2] ASoC: dfbmcs320: make the driver common for other BT
 modules
In-Reply-To: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130517111523.GM1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 10:19:37AM +0800, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
> we don't want everyone to have a seperate codec driver. anyway, the
> feature of Bluetooth handsfree is same on all platforms, so this patch
> makes the DFBM-CS320 driver become a common BT handsfree driver.

Sorry, should have thought of this before but why are we calling this
"handsfree"?  It's just a generic bluetooth link as far as the host
system is concerned, "bt-sco" might be more appropriate?

Otherwise this looks OK for ASoC though I'd expect to see a change to
registration of the OpenMoko BT device (perhaps I missed it though).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/09653d70/attachment.sig>

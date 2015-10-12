From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 16:20:28 +0200
Subject: [PATCH] samples: build configfs sample on when enabled
In-Reply-To: <6271650.CdczvJuMsL@wuerfel>
References: <6271650.CdczvJuMsL@wuerfel>
Message-ID: <20151012142028.GA24695@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 04:14:16PM +0200, Arnd Bergmann wrote:
> Most samples have their own Kconfig option, but for some reason
> the configfs sample does not have one and gets built unconditionally
> when CONFIG_SAMPLES is enabled, which fails if CONFIG_CONFIGFS_FS
> is not:
> 
> ERROR: "configfs_unregister_subsystem" [samples/configfs/configfs_sample.ko] undefined!
> ERROR: "configfs_register_subsystem" [samples/configfs/configfs_sample.ko] undefined!
> 
> This adds a new Kconfig symbol to mirror the existing method and
> only let the user enable this sample if configfs is present.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This should already be in version two of the series I sent last week.

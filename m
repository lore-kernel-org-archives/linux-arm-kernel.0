From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Mar 2012 21:18:09 +0000
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for
 first instance
In-Reply-To: <1331080771-30687-1-git-send-email-khilman@ti.com>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
Message-ID: <201203192118.09286.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Kevin Hilman wrote:
> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
> regulators) added regulators which are registered during
> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
> than one instance of the SMSC911x and result in attempting to register
> the same regulator more than once which causes a panic().
> 
> Fix this by only registering the regulator when the platform_data id
> field is zero, indicating its the first instance.
> 
> Cc: Matt Porter <mporter@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

It seems that both Olof and I forgot to forward this one to Linus.

If it's ok for you, I'll add it to the fixes branch for v3.4 now
and mark it for backporting to v3.3-stable.

Sorry for the inconvenience.


	Arnd

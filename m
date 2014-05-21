From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 21 May 2014 11:41:25 +0530
Subject: [PATCH 1/2] dmaengine: omap: hide filter_fn for built-in drivers
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <20140521061125.GN21128@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:56:12PM +0200, Arnd Bergmann wrote:
> It is not possible to reference the omap_dma_filter_fn filter
> function from a built-in driver if the dmaengine driver itself
> is a loadable module, which is a valid configuration otherwise.
> 
> This provides only the dummy alternative if the function
> is referenced by a built-in driver to allow a successful
> build. The filter function is only required by ATAGS based
> platforms, which will continue to be broken after this change
> for the bogus configuration. When booting from DT, with the
> dma channels correctly listed there, it will work fine.

Applied, both thanks

-- 
~Vinod

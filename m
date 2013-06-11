From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 11 Jun 2013 09:47:13 +0000 (UTC)
Subject: [PATCH 3/3] clk: tegra: T114: add DFLL DVCO reset control
In-Reply-To: <51B6D239.5030905@nvidia.com>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121901.21868.65416.stgit@dusk.lan> <51B21105.1080301@wwwdotorg.org>
 <alpine.DEB.2.02.1306071703050.7753@utopia.booyaka.com>
 <51B6D239.5030905@nvidia.com>
Message-ID: <alpine.DEB.2.02.1306110944130.22645@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013, Prashant Gaikwad wrote:

> Why not implement these APIs in DFLL clock driver itself and pass RST address
> register to driver?

The DFLL DVCO reset registers are CAR registers, not DFLL registers.  
Functions that operate on registers in one IP block shouldn't be located 
in another IP block's driver.


- Paul

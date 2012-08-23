From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 23 Aug 2012 09:29:40 +0530
Subject: [PATCH v2 3/3] spi: spi-davinci: convert to DMA engine API
In-Reply-To: <20120822160417.GA27758@beef>
References: <1345574589-24757-1-git-send-email-mporter@ti.com>
 <1345574589-24757-4-git-send-email-mporter@ti.com>
 <1345607122.1895.44.camel@vkoul-udesk3>  <20120822160417.GA27758@beef>
Message-ID: <1345694380.1895.87.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-22 at 12:04 -0400, Matt Porter wrote:
> for querying of these types of limitations. Right now, the
> mmc driver implicitly knows that EDMA needs this restriction
> but it's something that should be queried before calling
> prep_slave().
that's something we need to add; exporting channel capabilities. We only
tell that it slave or memcpy today, but we need to tell clients what are
channel supported parameter ranges.

-- 
~Vinod

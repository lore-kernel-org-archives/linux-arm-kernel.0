From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 08:43:57 +0530
Subject: [PATCH v3 02/15] dmaengine: omap: Add support for pause/resume
 in cyclic dma mode
In-Reply-To: <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347851637.1943.125.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> -       /* FIXME: not supported by platform private API */
> -       return -EINVAL;
> +       /* Pause/Resume only allowed with cyclic mode */
> +       if (!c->cyclic)
> +               return -EINVAL; 
This is not a dma restriction right?

-- 
~Vinod

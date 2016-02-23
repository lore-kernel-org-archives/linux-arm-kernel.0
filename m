From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 23 Feb 2016 08:43:36 +0530
Subject: [PATCH v2 4/4] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <1455569868-25017-4-git-send-email-robert.jarzmik@free.fr>
References: <1455569868-25017-1-git-send-email-robert.jarzmik@free.fr>
 <1455569868-25017-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160223031335.GJ17690@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 09:57:48PM +0100, Robert Jarzmik wrote:
> The current number of requestor lines is limited to 31. This was an
> error of a previous commit, as this number is platform dependent, and is
> actually :
>  - for pxa25x: 40 requestor lines
>  - for pxa27x: 75 requestor lines
>  - for pxa3xx: 100 requestor lines
> 
> The previous testing did not reveal the faulty constant as on pxa[23]xx
> platforms, only camera, MSL and USB are above requestor 32, and in these
> only the camera has a driver using dma.
> 
> Fixes: e87ffbdf0697 ("dmaengine: pxa_dma: fix the no-requestor case")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Vinod Koul <vinod.koul@intel.com>

Which tree is this targetted thru?

-- 
~Vinod

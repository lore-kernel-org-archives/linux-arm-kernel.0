From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 30 Sep 2015 11:50:44 +0530
Subject: [PATCH 2/2] dma: pxa_dma: fix residue corner case
In-Reply-To: <1441905466-17459-2-git-send-email-robert.jarzmik@free.fr>
References: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
 <1441905466-17459-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150930062044.GB21690@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 07:17:46PM +0200, Robert Jarzmik wrote:
> A very tiny temporal window exists in the residue calculation where :
>  - upon entering residue calculation, the transfer is ongoing
>  - when reading the current transfer pointer, it just changed to
>    the "finisher/linker" descriptor
> 
> In this case, the he residue returned is thw whole transfer length
> instead of 0. Fix it.
Two many typos here :(


-- 
~Vinod

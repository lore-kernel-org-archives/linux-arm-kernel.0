From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Aug 2013 17:02:00 +0530
Subject: [PATCH v2] dmaengine: sirf: add PM entries for sleep and runtime
In-Reply-To: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
References: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130813113200.GE32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 05:44:34PM +0800, Barry Song wrote:
> this patch adds PM ops entries in sirf-dma drivers, so that this
> driver can support suspend/resume, hibernation and runtime PM.
> 
> while suspending, sirf-dma will lose all registers, so we save
> them at suspend and restore in resume for active channels.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Applied, thanks

Although putting runtime_get/put in submit and callback would be much more
better than alloc/free implementation

~Vinod

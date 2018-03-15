From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 15 Mar 2018 16:23:46 -0600
Subject: [PATCH 3/7] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1520997629-17361-3-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20180315222346.GC27537@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 11:20:24PM -0400, Sinan Kaya wrote:
> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to RDMA for-next

Thanks,
Jason

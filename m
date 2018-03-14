From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 13 Mar 2018 22:12:49 -0600
Subject: [PATCH 3/7] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1520997629-17361-3-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20180314041249.GA18314@ziepe.ca>
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
>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sure matches my understanding of writel_relaxed

This is part of a series, should we take just this patch through the
rdma tree? If not:

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Jason

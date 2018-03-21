From: shiraz.saleem@intel.com (Shiraz Saleem)
Date: Wed, 21 Mar 2018 08:38:06 -0500
Subject: [PATCH v4 3/6] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20180321133805.GA25412@ssaleem-MOBL4.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 08:47:45PM -0600, Sinan Kaya wrote:
> Code includes wmb() followed by writel(). writel() already has a barrier on
> some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Create a new wrapper function with relaxed write operator. Use the new
> wrapper when a write is following a wmb().
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

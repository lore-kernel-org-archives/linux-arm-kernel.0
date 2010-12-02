From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 12:33:04 +0000
Subject: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
In-Reply-To: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
Message-ID: <20101202123304.GB10461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
> Hi Tony,
> 
> The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:
>   Linus Torvalds (1):
>         Linux 2.6.37-rc4
> 
> are available in the git repository at:
> 
>   git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38
> 
> Fernando Guzman Lugo (5):
>       OMAP: mailbox: change full flag per mailbox queue instead of global
>       omap: iovmm - no gap checking for fixed address
>       omap: iovmm - add superpages support to fixed da address
>       omap: iovmm - replace __iounmap with omap_iounmap

This change is wrong.  Nothing should be directly referencing omap_iounmap
nor for that matter omap_ioremap.  Both are implementation details of the
standard ioremap/iounmap APIs.

Use the official APIs rather than the implementation details behind them.

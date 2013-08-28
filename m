From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 28 Aug 2013 20:52:29 +0100
Subject: [PATCH v4 06/10] xen/arm,arm64: move Xen initialization
 earlier
In-Reply-To: <20130819165502.GC19712@arm.com>
References: <alpine.DEB.2.02.1308151200580.4470@kaball.uk.xensource.com>
 <1376565054-24153-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130819165502.GC19712@arm.com>
Message-ID: <alpine.DEB.2.02.1308282050330.6397@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Aug 2013, Catalin Marinas wrote:
> On Thu, Aug 15, 2013 at 12:10:50PM +0100, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> Some explanation on why and how early it needs to be moved?

It only needs to be moved before any dma requests are made.
I am not sure exactly where the right place for it would be but I was
pretty sure that right after psci_init would be early enough.

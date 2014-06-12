From: msalter@redhat.com (Mark Salter)
Date: Thu, 12 Jun 2014 09:57:39 -0400
Subject: [PATCH] arm64: fix MAX_ORDER for 64K pagesize
In-Reply-To: <alpine.DEB.2.02.1406111604060.27885@chino.kir.corp.google.com>
References: <1402522435-13884-1-git-send-email-msalter@redhat.com>
 <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
 <alpine.DEB.2.02.1406111604060.27885@chino.kir.corp.google.com>
Message-ID: <1402581459.15402.54.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-06-11 at 16:04 -0700, David Rientjes wrote:
> On Wed, 11 Jun 2014, David Rientjes wrote:
> 
> > Any reason to not switch this to
> > 
> > 	ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE && CMA
> > 
> 
> (ARM64_64K_PAGES) && (TRANSPARENT_HUGEPAGE || CMA)

And add HUGETLB to the list also? I'm not sure of all the trade offs
here, so I kept it simple. I don't have a strong opinion one way or
the other.

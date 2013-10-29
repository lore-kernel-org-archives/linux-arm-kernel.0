From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Oct 2013 16:41:42 +0000
Subject: [PATCH v2] arm64: allow ioremap_cache() to use existing RAM
 mappings
In-Reply-To: <1382626457.1768.80.camel@deneb.redhat.com>
References: <1382362594-24947-1-git-send-email-msalter@redhat.com>
 <1382519898.10408.1.camel@mbp>
 <1382535972.1768.68.camel@deneb.redhat.com>
 <20131023143717.GA19317@mbp>
 <1382626457.1768.80.camel@deneb.redhat.com>
Message-ID: <20131029164142.GF3472@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 03:54:17PM +0100, Mark Salter wrote:
> Some drivers (ACPI notably) use ioremap_cache() to map an area which could
> either be outside of kernel RAM or in an already mapped reserved area of
> RAM. To avoid aliases with different caching attributes, ioremap() does
> not allow RAM to be remapped. But for ioremap_cache(), the existing kernel
> mapping may be used.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Looks good. Thanks.

-- 
Catalin

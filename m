From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 15 Nov 2018 01:41:16 -0800
Subject: [PATCH] arm64: Make kpti command line options x86 compatible
In-Reply-To: <20181113152046.22389-1-agraf@suse.de>
References: <20181113152046.22389-1-agraf@suse.de>
Message-ID: <20181115094116.GA18154@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 04:20:46PM +0100, Alexander Graf wrote:
> I've already stumbled over 2 cases where people got confused about how to
> disable kpti on AArch64. In both cases, they used existing x86_64 options
> and just applied that to an AArch64 system, expecting it to work.
> 
> I think it makes a lot of sense to have compatible kernel command line
> parameters whenever we can have them be compatible.
> 
> So this patch adds the pti= and no_pti kernel command line options, mapping
> them into the existing kpti= command line framework. It preserves the old
> syntax to maintain compatibility with older command lines.
> 
> While at it, the patch also marks the respective options as dual-arch.

Thanks.  Which also brings up my old complain? that arm64 and x86 should
use the same config option.  Bonus points for moving the parsing code
to a common file..

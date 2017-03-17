From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Mar 2017 20:31:18 +0900
Subject: [PATCH v33 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <1489747566.17202.19.camel@infradead.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-2-takahiro.akashi@linaro.org>
 <1489747566.17202.19.camel@infradead.org>
Message-ID: <20170317113116.GB11935@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 10:46:06AM +0000, David Woodhouse wrote:
> On Wed, 2017-03-15 at 18:59 +0900, AKASHI Takahiro wrote:
> > 
> > +pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> > +crash_base, crash_base + crash_size, crash_size >> 20);
> 
> There's a typo there ? it says MB but you mean MiB.
> 
> Unless you meant crash_size / 1000000 and not crash_size >> 20?

Yes and no.
This notation is consistent with other places like mem_init()
in mm/init.c.

Thanks,
-Takahiro AKASHI

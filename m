From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 9 May 2013 09:15:05 +0100
Subject: [RFC PATCH v2 08/11] ARM64: mm: Swap PTE_FILE and
 PTE_PROT_NONE bits.
In-Reply-To: <518A7A9F.9080105@codeaurora.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-9-git-send-email-steve.capper@linaro.org>
 <518A7A9F.9080105@codeaurora.org>
Message-ID: <20130509081504.GA28545@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 12:17:35PM -0400, Christopher Covington wrote:
> Hi Steve,
> 
> On 05/08/2013 05:52 AM, Steve Capper wrote:
 
 [...]
> 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> 
 [...]
> 
> > @@ -306,8 +306,8 @@ extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> >  
> >  /*
> >   * Encode and decode a file entry:
> > - *	bits 0-1:	present (must be zero)
> > - *	bit  2:		PTE_FILE
> > + *	bits 0 & 2:	present (must be zero)
> 
> Consider using punctuation like "bits 0, 2" here to disambiguate from the
> binary and operation.
> 

Hi Christopher,
Thanks, I now have:
       bits 0, 2:      present (must both be zero)

Cheers,
-- 
Steve

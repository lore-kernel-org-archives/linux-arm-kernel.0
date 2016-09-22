From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Sep 2016 10:17:43 +0100
Subject: [PATCHv2] arm64: Correctly bounds check virt_addr_valid
In-Reply-To: <1474496704-30541-1-git-send-email-labbott@redhat.com>
References: <1474496704-30541-1-git-send-email-labbott@redhat.com>
Message-ID: <20160922091743.GB22670@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 03:25:04PM -0700, Laura Abbott wrote:
> 
> virt_addr_valid is supposed to return true if and only if virt_to_page
> returns a valid page structure. The current macro does math on whatever
> address is given and passes that to pfn_valid to verify. vmalloc and
> module addresses can happen to generate a pfn that 'happens' to be
> valid. Fix this by only performing the pfn_valid check on addresses that
> have the potential to be valid.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Properly parenthesize macro arguments. Re-factor to common macro.
> 
> Also in case it wasn't clear, there's no need to try and squeeze this
> into 4.8. Hardened usercopy should have all the checks, this is just for
> full correctness.

Thanks, I'll push this onto for-next/core later today.

Will

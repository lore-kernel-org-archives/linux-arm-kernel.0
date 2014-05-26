From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 26 May 2014 17:28:14 +0200
Subject: [PATCH v3 03/14] ARM: KVM: handle 64bit values passed to mrcc or
 from mcrr instructions in BE case
In-Reply-To: <1399997646-4716-4-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-4-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140526152814.GB31431@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:13:55AM -0700, Victor Kamensky wrote:
> In some cases the mcrr and mrrc instructions in combination with the ldrd
> and strd instructions need to deal with 64bit value in memory. The ldrd
> and strd instructions already handle endianness within word (register)
> boundaries but to get effect of the whole 64bit value represented correctly,
> rr_lo_hi macro is introduced and is used to swap registers positions when
> the mcrr and mrrc instructions are used. That has the effect of swapping
> two words.

So in this version you decided to keep the ordering of the TTBRX and
TTBRX_high bits (high being most significant).  I assume this is because
of the trapping of VM registers introduced by mark and to maintain
access_vm_reg()?

Any other changes since the last version?

If none, then for the content of this patch:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

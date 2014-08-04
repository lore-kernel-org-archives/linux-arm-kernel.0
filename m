From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 4 Aug 2014 12:36:24 +0200
Subject: [PATCH] arm/arm64: KVM: Support KVM_CAP_READONLY_MEM
In-Reply-To: <1405003351-12973-1-git-send-email-christoffer.dall@linaro.org>
References: <1405003351-12973-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20140804103624.GA32684@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 07:42:31AM -0700, Christoffer Dall wrote:
> When userspace loads code and data in a read-only memory regions, KVM
> needs to be able to handle this on arm and arm64.  Specifically this is
> used when running code directly from a read-only flash device; the
> common scenario is a UEFI blob loaded with the -bios option in QEMU.
> 
> To avoid looking through the memslots twice and to reuse the hva error
> checking of gfn_to_hva_prot(), add a new gfn_to_hva_memslot_prot()
> function and refactor gfn_to_hva_prot() to use this function.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> Note that if you want to test this with QEMU, you need to update the
> uapi headers.  You can also grab the branch below from my qemu git tree
> with the temporary update headers patch applied on top of Peter
> Maydell's -bios in -M virt support patches:
> 
> git://git.linaro.org/people/christoffer.dall/qemu-arm.git virt-for-uefi
> 

Ping?

-Christoffer

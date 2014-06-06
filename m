From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 6 Jun 2014 11:16:03 +0200
Subject: [PATCH v3] ARM: KVM: Unmap IPA on memslot delete/move
In-Reply-To: <1402045823-26912-1-git-send-email-eric.auger@linaro.org>
References: <1402045823-26912-1-git-send-email-eric.auger@linaro.org>
Message-ID: <20140606091603.GA22341@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 11:10:23AM +0200, Eric Auger wrote:
> Currently when a KVM region is deleted or moved after
> KVM_SET_USER_MEMORY_REGION ioctl, the corresponding
> intermediate physical memory is not unmapped.
> 
> This patch corrects this and unmaps the region's IPA range
> in kvm_arch_commit_memory_region using unmap_stage2_range.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>

I think I already acked it in the last version, if Marc is ok with it, I
can queue it for next.

-Christoffer

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 4 Aug 2014 14:06:48 +0200
Subject: [PATCH V2] ARM/ARM64: KVM: Nuke Hyp-mode tlbs before enabling MMU
In-Reply-To: <1406789604-10533-1-git-send-email-pranavkumar@linaro.org>
References: <1406789604-10533-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <20140804120648.GB524@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 12:23:23PM +0530, Pranavkumar Sawargaonkar wrote:
> X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
> have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.
> 
> This can happen on any ARM/ARM64 board running bootloader in
> Hyp-mode (or EL2-mode) with MMU enabled.
> 
> This patch ensures that we flush all Hyp-mode (or EL2-mode) TLBs
> on each host CPU before enabling Hyp-mode (or EL2-mode) MMU.
> 
> Changelog:
> 
> V2:
>  - Flush Hyp-mode TLBs for both KVM ARM32 and KVM ARM64 at boot time
> 
> V1:
>  - Initial patch with only arm64 change
> 
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

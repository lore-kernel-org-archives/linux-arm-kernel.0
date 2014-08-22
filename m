From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Aug 2014 10:03:43 +0100
Subject: [PATCH V2] ARM/ARM64: KVM: Nuke Hyp-mode tlbs before enabling MMU
In-Reply-To: <20140804120648.GB524@cbox>
References: <1406789604-10533-1-git-send-email-pranavkumar@linaro.org>
 <20140804120648.GB524@cbox>
Message-ID: <53F7076F.1010502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/14 13:06, Christoffer Dall wrote:
> On Thu, Jul 31, 2014 at 12:23:23PM +0530, Pranavkumar Sawargaonkar wrote:
>> X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
>> have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.
>>
>> This can happen on any ARM/ARM64 board running bootloader in
>> Hyp-mode (or EL2-mode) with MMU enabled.
>>
>> This patch ensures that we flush all Hyp-mode (or EL2-mode) TLBs
>> on each host CPU before enabling Hyp-mode (or EL2-mode) MMU.
>>
>> Changelog:
>>
>> V2:
>>  - Flush Hyp-mode TLBs for both KVM ARM32 and KVM ARM64 at boot time
>>
>> V1:
>>  - Initial patch with only arm64 change
>>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

This should probably go in quickly as a fix.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

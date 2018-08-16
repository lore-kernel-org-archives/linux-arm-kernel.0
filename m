From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Aug 2018 17:11:33 -0700
Subject: [PATCH 1/1] arm64: dts: Stingray: Adjust SMMU non-secure context
 interrupt
In-Reply-To: <CAOA9gs3qHV9UazZKuxtgijpDVUJN18LkGxFAkv8=YMb8RepxHQ@mail.gmail.com>
References: <1533632824-17436-1-git-send-email-jitendra.bhivare@broadcom.com>
 <77afc740-7fbb-7d6d-6a9a-594c5b09d30a@broadcom.com>
 <CAOA9gs3qHV9UazZKuxtgijpDVUJN18LkGxFAkv8=YMb8RepxHQ@mail.gmail.com>
Message-ID: <b1ef8e46-34d1-23c4-52b6-424f40b132a6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2018 04:20 AM, Jitendra Bhivare wrote:
> Thanks Robin, Vivek commit should do. For older kernels will push that
> commit.

Do you mean you are going to keep this patch downstream and apply it to
the relevant kernel versions you maintain, or do you expect to resubmit
this very patch with a Fixes: tag and include information as to which
stable tree this should be applied to?

> 
> On Tuesday, August 7, 2018, Ray Jui <ray.jui@broadcom.com
> <mailto:ray.jui@broadcom.com>> wrote:
> 
> 
> 
>     On 8/7/2018 2:07 AM, Jitendra Bhivare wrote:
> 
>         From: Pramod Kumar <pramod.kumar@broadcom.com
>         <mailto:pramod.kumar@broadcom.com>>
> 
>         One context bank has been reserved for secure master, CRMU.
>         hence need to remove context interrupt accordingly. Doing
>         the same in this patch.
> 
> 
>     I thought you need proper "Fixes" tag so this can be back ported to
>     older kernels.
> 
> 
>         Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com
>         <mailto:pramod.kumar@broadcom.com>>
>         Reviewed-by: Ray Jui <ray.jui@broadcom.com
>         <mailto:ray.jui@broadcom.com>>
>         Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com
>         <mailto:vikram.prakash@broadcom.com>>
>         ---
>         ? arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 3 +--
>         ? 1 file changed, 1 insertion(+), 2 deletions(-)
> 
>         diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
>         b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
>         index b203152..7fcaf38 100644
>         --- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
>         +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
>         @@ -244,8 +244,7 @@
>         ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?<GIC_SPI 770
>         IRQ_TYPE_LEVEL_HIGH>,
>         ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?<GIC_SPI 771
>         IRQ_TYPE_LEVEL_HIGH>,
>         ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?<GIC_SPI 772
>         IRQ_TYPE_LEVEL_HIGH>,
>         -? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? <GIC_SPI 773
>         IRQ_TYPE_LEVEL_HIGH>,
>         -? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? <GIC_SPI 774
>         IRQ_TYPE_LEVEL_HIGH>;
>         +? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? <GIC_SPI 773
>         IRQ_TYPE_LEVEL_HIGH>;
>         ? ? ? ? ? ? ? ? ? ? ? ? #iommu-cells = <2>;
>         ? ? ? ? ? ? ? ? };
>         ? ? ? ? };
> 


-- 
Florian

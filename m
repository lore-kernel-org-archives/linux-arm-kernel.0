From: eric.auger@redhat.com (Auger Eric)
Date: Fri, 27 Jan 2017 09:39:40 +0100
Subject: [PATCH v11 8/8] arm/arm64: Documentation: Update arm-vgic-v3.txt
In-Reply-To: <1485440453-10597-9-git-send-email-vijay.kilari@gmail.com>
References: <1485440453-10597-1-git-send-email-vijay.kilari@gmail.com>
 <1485440453-10597-9-git-send-email-vijay.kilari@gmail.com>
Message-ID: <726199b6-2c0f-6efe-23d7-c5aceba0ff97@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On 26/01/2017 15:20, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> Update error code returned for Invalid CPU interface register
> value and access in AArch32 mode.
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> index 9348b3c..c1a2461 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> @@ -118,7 +118,7 @@ Groups:
>      -EBUSY: One or more VCPUs are running
>  
>  
> -  KVM_DEV_ARM_VGIC_CPU_SYSREGS
> +  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS
>    Attributes:
>      The attr field of kvm_device_attr encodes two values:
>      bits:     | 63      ....       32 | 31  ....  16 | 15  ....  0 |
> @@ -139,13 +139,15 @@ Groups:
>      All system regs accessed through this API are (rw, 64-bit) and
>      kvm_device_attr.addr points to a __u64 value.
>  
> -    KVM_DEV_ARM_VGIC_CPU_SYSREGS accesses the CPU interface registers for the
> +    KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS accesses the CPU interface registers for the
>      CPU specified by the mpidr field.
>  
> +    CPU interface registers access is not implemented for AArch32 mode.
> +    Error -ENXIO is returned when accessed in AArch32 mode.
>    Errors:
>      -ENXIO: Getting or setting this register is not yet supported
>      -EBUSY: VCPU is running
> -    -EINVAL: Invalid mpidr supplied
> +    -EINVAL: Invalid mpidr or register value supplied
>  
>  
>    KVM_DEV_ARM_VGIC_GRP_NR_IRQS
> @@ -204,3 +206,6 @@ Groups:
>      architecture defined MPIDR, and the field is encoded as follows:
>        | 63 .... 56 | 55 .... 48 | 47 .... 40 | 39 .... 32 |
>        |    Aff3    |    Aff2    |    Aff1    |    Aff0    |
> +  Errors:
> +    -EINVAL: vINTID is not multiple of 32 or
> +     info field is not VGIC_LEVEL_INFO_LINE_LEVEL
> 

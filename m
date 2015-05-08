From: treding@nvidia.com (Thierry Reding)
Date: Fri, 8 May 2015 13:26:17 +0200
Subject: [PATCH 1/2] ARM: Availability of psci_smp_available depends on
 CONFIG_SMP
In-Reply-To: <0f0a77ddee48027efa35f36d6c809d2d3ff91ce1.1431064527.git.jan.kiszka@siemens.com>
References: <cover.1431064527.git.jan.kiszka@siemens.com>
 <0f0a77ddee48027efa35f36d6c809d2d3ff91ce1.1431064527.git.jan.kiszka@siemens.com>
Message-ID: <20150508112615.GE32221@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 07:55:26AM +0200, Jan Kiszka wrote:
> Ensure that we can use psci_smp_available without checking for
> CONFIG_SMP first.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/include/asm/psci.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> index c25ef3e..eef6a0a 100644
> --- a/arch/arm/include/asm/psci.h
> +++ b/arch/arm/include/asm/psci.h
> @@ -39,9 +39,13 @@ extern struct smp_operations psci_smp_ops;
>  
>  #ifdef CONFIG_ARM_PSCI
>  int psci_init(void);
> -bool psci_smp_available(void);
>  #else
>  static inline int psci_init(void) { return 0; }
> +#endif
> +
> +#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
> +bool psci_smp_available(void);
> +#else
>  static inline bool psci_smp_available(void) { return false; }
>  #endif
>  

Looks good to me.

Russell, would you be willing to ack this patch so that I can take it
through the Tegra tree along with patch 2/2 that depends on this?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/3f33b4f0/attachment.sig>

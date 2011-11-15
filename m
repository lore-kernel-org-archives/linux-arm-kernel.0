From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 15 Nov 2011 16:18:45 +0400
Subject: [PATCH v4 2/4] ARM: davinci: psc: fix incorrect offsets
In-Reply-To: <1321301529-7582-2-git-send-email-nsekhar@ti.com>
References: <1321301529-7582-1-git-send-email-nsekhar@ti.com>
 <1321301529-7582-2-git-send-email-nsekhar@ti.com>
Message-ID: <4EC258A5.3030207@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-11-2011 0:12, Sekhar Nori wrote:

> From: Murali Karicheri<m-karicheri2@ti.com>

> Seperate PDSTAT and PDCTL registers are defined for
> domain 0 and domain 1 where as the code always reads
> the domain 0 PDSTAT register and domain 1 PDCTL register.

> Fix this issue. While at it, introduce usage of macros
> for register masks to improve readability.

> Reviewed-by: Sergei Shtylyov<sshtylyov@mvista.com>
> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> ---
>   arch/arm/mach-davinci/include/mach/psc.h |    4 +++-
>   arch/arm/mach-davinci/psc.c              |   16 ++++++++--------
>   2 files changed, 11 insertions(+), 9 deletions(-)

> diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
> index 8bf279a..8bc3fc2 100644
> --- a/arch/arm/mach-davinci/include/mach/psc.h
> +++ b/arch/arm/mach-davinci/include/mach/psc.h
[...]
> @@ -246,6 +246,8 @@
>   #define MDSTAT_STATE_MASK	0x3f
>   #define PDSTAT_STATE_MASK	0x1f
>   #define MDCTL_FORCE		BIT(31)
> +#define PDCTL_NEXT		BIT(1)

    BIT(0) actually.

WBR, Sergei

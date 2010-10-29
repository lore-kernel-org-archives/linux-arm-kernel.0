From: eric.y.miao@gmail.com (eric.y.miao at gmail.com)
Date: Fri, 29 Oct 2010 21:48:39 +0800
Subject: [PATCH] ARM: mmp: fix cpuid detection on mmp2
In-Reply-To: <1288323176-6970-1-git-send-email-haojian.zhuang@marvell.com>
References: <1288323176-6970-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTimrkrha549h8cVDn0HF4YNB+MUwuPek-D-AZs_O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 29, 2010 at 11:32 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Fix typo error on cpu_is_mmp2(). Correct cpu_readid_id() to read_cpuid_id().
> Append missing parenthesis.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Merged.

> ---
> ?arch/arm/mach-mmp/include/mach/cputype.h | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/cputype.h b/arch/arm/mach-mmp/include/mach/cputype.h
> index f43a68b..8a3b56d 100644
> --- a/arch/arm/mach-mmp/include/mach/cputype.h
> +++ b/arch/arm/mach-mmp/include/mach/cputype.h
> @@ -46,7 +46,8 @@ static inline int cpu_is_pxa910(void)
> ?#ifdef CONFIG_CPU_MMP2
> ?static inline int cpu_is_mmp2(void)
> ?{
> - ? ? ? return (((cpu_readid_id() >> 8) & 0xff) == 0x58);
> + ? ? ? return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
> +}
> ?#else
> ?#define cpu_is_mmp2() ?(0)
> ?#endif
> --
> 1.5.6.5
>
>

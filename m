From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Jun 2014 21:25:48 +0900
Subject: [PATCH] ARM: shmobile: rcar-gen2: correct return value of
 shmobile_smp_apmu_suspend_init
In-Reply-To: <539EDF72.7080305@cogentembedded.com>
References: <1402918044-29961-1-git-send-email-horms+renesas@verge.net.au>
 <539EDF72.7080305@cogentembedded.com>
Message-ID: <20140616122548.GA30357@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 04:13:38PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/16/2014 03:27 PM, Simon Horman wrote:
> 
> >The dummy shmobile_smp_apmu_suspend_init() function provided when
> >CPU_IDLE is not set should not return a value as per the signature
> >of the function.
> 
> >This problem appears to have been introduced by
> >867ba81f728f1daa ("ARM: shmobile: APMU: Add Core-Standby-state for Suspend
> >to RAM").
> 
> >Cc: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> [...]
> 
> >diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> >index 8f0cd57..46766fc 100644
> >--- a/arch/arm/mach-shmobile/include/mach/common.h
> >+++ b/arch/arm/mach-shmobile/include/mach/common.h
> >@@ -38,7 +38,7 @@ int shmobile_suspend_init(void);
> >  void shmobile_smp_apmu_suspend_init(void);
> >  #else
> >  static inline int shmobile_suspend_init(void) { return 0; }
> >-static inline void shmobile_smp_apmu_suspend_init(void) { return 0; }
> >+static inline void shmobile_smp_apmu_suspend_init(void) { return; }
> 
>    I wonder why you kept *return* at all?

Thanks, I will remove it.

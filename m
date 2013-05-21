From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 May 2013 23:31:39 -0700
Subject: [PATCH] ARM: vt8500: Add missing NULL terminator in dt_compat
In-Reply-To: <5195EA34.7000409@prisktech.co.nz>
References: <1368776657-23035-1-git-send-email-srinivas.kandagatla@st.com>
 <5195EA34.7000409@prisktech.co.nz>
Message-ID: <20130521063139.GA20453@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 08:28:36PM +1200, Tony Prisk wrote:
> On 17/05/13 19:44, Srinivas KANDAGATLA wrote:
> >From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> >
> >When I tried booting a stih415 Dual core A9 with multi_v7_defconfig, it
> >failed to boot. The issues seems to be changing by enabling or disabling
> >VT8550 platform. Having a quick look at dt_compat list, it seems to miss
> >a NULL terminator, which means of_flat_dt_match will compat check will
> >cross the boundary of dt_compat and fault at some point , which is what
> >was happening in my case.
> >
> >Without this patch if we try to boot multi_v7_defconfig you might notice
> >that some of the platforms might fault if they fall after vt8500 in
> >machine-desc list. Other platforms which fall before vt8500 in mdesc list
> >will not fault.
> >
> >Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> >---
> >  arch/arm/mach-vt8500/vt8500.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
> >index 1dd281e..f5c33df 100644
> >--- a/arch/arm/mach-vt8500/vt8500.c
> >+++ b/arch/arm/mach-vt8500/vt8500.c
> >@@ -173,6 +173,7 @@ static const char * const vt8500_dt_compat[] = {
> >  	"wm,wm8505",
> >  	"wm,wm8750",
> >  	"wm,wm8850",
> >+	NULL
> >  };
> >  DT_MACHINE_START(WMT_DT, "VIA/Wondermedia SoC (Device Tree Support)")
> My bad. Thanks for the fix.
> 
> Acked-by: Tony Prisk <linux@prisktech.co.nz>
> 
> Arnd, Olof: Can you apply this directly please.

Done.

Thanks,

-Olof

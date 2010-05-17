From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 17 May 2010 16:10:52 +0530
Subject: [PATCH Resend] Watchdog: Adding support for Watchdog found with
	ARM	CortexA9
In-Reply-To: <4BF11B51.7000808@st.com>
References: <1274090321-14665-1-git-send-email-viresh.kumar@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C558B841@dbde02.ent.ti.com>
	<4BF11B51.7000808@st.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C558B870@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Viresh KUMAR [mailto:viresh.kumar at st.com]
> Sent: Monday, May 17, 2010 4:03 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; armando.visconti at st.com; shiraz.hashim at st.com;
> linus.walleij at stericsson.com
> Subject: Re: [PATCH Resend] Watchdog: Adding support for Watchdog found with ARM CortexA9
> 
> On 5/17/2010 3:49 PM, Shilimkar, Santosh wrote:
> > <snip>
> >> -----Original Message-----
> >> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> >> bounces at lists.infradead.org] On Behalf Of Viresh KUMAR
> >> Sent: Monday, May 17, 2010 3:29 PM
> >> To: linux-arm-kernel at lists.infradead.org
> >> Cc: armando.visconti at st.com; shiraz.hashim at st.com; Viresh Kumar; linus.walleij at stericsson.com
> >> Subject: [PATCH Resend] Watchdog: Adding support for Watchdog found with ARM CortexA9
> >>
> >> Watchdog details can be found in ARM Cortex A9 reference manual at:
> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407e/indix.html
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> >> ---
> >>  drivers/watchdog/Kconfig        |    7 +
> >>  drivers/watchdog/Makefile       |    1 +
> >>  drivers/watchdog/cortexa9_wdt.c |  414 +++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 422 insertions(+), 0 deletions(-)
> >>  create mode 100644 drivers/watchdog/cortexa9_wdt.c
> >>
> >> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> index 0bf5020..b5c0f6f 100644
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -73,6 +73,13 @@ config WM8350_WATCHDOG
> >>
> >>  # ARM Architecture
> >>
> >> +config ARM_CORTEXA9_WATCHDOG
> >> +	tristate "ARM CortexA9 Watchdog"
> >> +	depends on ARM_AMBA
> >
> > What is the ARM_AMBA dependency with CA-9 watchdog?
> 
> Not really on amba, rather on ARM. Or CPU_V7 (cortex related)?
> Maybe some other ARM core also have similar design,
> so can keep it dependent on ARM. Does this looks fine?
> 
Thanks for clarification. Even CPU_V7 isn't correct dependency
because CA8 is based on V7 as well where the WDT isn't there.
So not sure about it. May be V7 + SMP might fit but not necessarily
correct again. Or you just leave it as "depends on ARM"

Regards,
Santosh

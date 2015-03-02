From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 2 Mar 2015 11:57:36 +0100
Subject: [PATCH] ARM: at91: pm: fix SRAM allocation
In-Reply-To: <7E7AE962-1BBE-4B33-9563-B91351494005@jcrosoft.com>
References: <1425292978-28135-1-git-send-email-alexandre.belloni@free-electrons.com>
 <7E7AE962-1BBE-4B33-9563-B91351494005@jcrosoft.com>
Message-ID: <20150302105736.GL4094@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2015 at 18:50:27 +0800, Jean-Christophe PLAGNIOL-VILLARD wrote :
> 
> > On Mar 2, 2015, at 6:42 PM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > 
> > On some platforms, there are multiple SRAM nodes defined in the device tree but
> > some of them are disabled, leading to allocation failure. Try to find the first
> > enabled SRAM node and allocate from it.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > arch/arm/mach-at91/pm.c | 20 +++++++++-----------
> > 1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> > index 5e34fb143309..97cc529b6fa0 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -272,35 +272,33 @@ static void __init at91_pm_sram_init(void)
> > 	struct device_node *node;
> > 	struct platform_device *pdev;
> 
> pdev not initialised at NULL

Indeed, I'll fix that. It doesn't really matter for now as all the
at91 DT have at least one sram node.

Wenyou, can you test it? If it works, I'll send v2.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

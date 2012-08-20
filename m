From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Aug 2012 10:02:10 +0200
Subject: [PATCH 5/6] ARM: integrator: convert AMBA devices to device tree
In-Reply-To: <CACRpkdZDMxk30YTkrumRveR3OuWptSpzNevrAvC2FxYShOZp-A@mail.gmail.com>
References: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
 <20120816124002.GB7439@game.jcrosoft.org>
 <CACRpkdZDMxk30YTkrumRveR3OuWptSpzNevrAvC2FxYShOZp-A@mail.gmail.com>
Message-ID: <20120820080210.GF7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:42 Sun 19 Aug     , Linus Walleij wrote:
> On Thu, Aug 16, 2012 at 2:40 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 14:16 Thu 16 Aug     , Linus Walleij wrote:
> >> +/* For the Device Tree, add in the UART callbacks as AUXDATA */
> >> +static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
> >> +     OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
> >> +             "rtc", NULL),
> >> +     OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART0_BASE,
> >> +             "uart0", &integrator_uart_data),
> >> +     OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART1_BASE,
> >> +             "uart1", &integrator_uart_data),
> >> +     OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
> >> +             "kmi0", NULL),
> >> +     OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
> >> +             "kmi1", NULL),
> >> +     { /* sentinel */ },
> 
> > why that?
> 
> Based on similar code by Grant in arch/arm/mach-versatile/core.c
> also ending with a {}. Also at other places ... I though this terminated
> the list iteration, is it not needed anymore?
no I mean why
> >> +     OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
> >> +             "rtc", NULL),
> >> +     OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
> >> +             "kmi0", NULL),
> >> +     OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
> >> +             "kmi1", NULL),

no platform data why do you use the AUXDATA?

as the OF_DEV_AUXDATA is deprecated now

Bset Regards,
J.

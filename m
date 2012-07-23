From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 23 Jul 2012 19:13:52 +0800
Subject: [PATCH v2 1/2] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120723105153.GS8265@arwen.pp.htv.fi>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-2-git-send-email-richard.zhao@freescale.com>
 <20120723091652.GK8265@arwen.pp.htv.fi>
 <20120723092713.GS21635@b20223-02.ap.freescale.net>
 <500D19AA.8080006@pengutronix.de>
 <20120723105153.GS8265@arwen.pp.htv.fi>
Message-ID: <20120723111351.GT21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 01:51:55PM +0300, Felipe Balbi wrote:
> On Mon, Jul 23, 2012 at 11:30:18AM +0200, Marc Kleine-Budde wrote:
> > On 07/23/2012 11:27 AM, Richard Zhao wrote:
> > >> This patch looks like a recipe for disaster IMHO, but it's Alex's call.
> > > Well, if there's any better place to hold it, I'd like to move there.
> > > Another place is arch/arm/mach-imx. Sascha/Shawn who are maintainers of
> > > imx are also in cc list.
> > 
> > IMHO it's not about the place where the driver is located, it's about
> > the shortcomings Michael and Sascha mentioned.
Thanks, Marc.
> 
> exactly. It's not about where a file is placed or how it's called. It's
> how you decided to implement it. This will prevent a platform with
> multiple instances of the IP to be used, at least.
To me, usbmisc on imx6 is just a set of non-core registers which is
companion of Chipidea IP cores. All cores share the same usbmisc.
>From design perspective, ci13xxx_imx knows nothing about usbmisc. It
just call the ops in proper occasion. usbmisc driver wrappers all
SoC specific things.
> 
> Also, if that set of registers are shared, you ought to have a dedicated
> driver to handle mutual exclusion and so on.
Only usbmisc driver access the registers, but maybe called from
different Chipidea devices. So it has a spinlock to protect register
access.
> I don't know details about
> the i.MX platform, that really smells funny by looking at it.

Thanks
Richard
> 
> -- 
> balbi

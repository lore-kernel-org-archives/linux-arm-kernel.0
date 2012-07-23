From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Jul 2012 13:51:55 +0300
Subject: [PATCH v2 1/2] USB: chipidea: add imx usbmisc support
In-Reply-To: <500D19AA.8080006@pengutronix.de>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-2-git-send-email-richard.zhao@freescale.com>
 <20120723091652.GK8265@arwen.pp.htv.fi>
 <20120723092713.GS21635@b20223-02.ap.freescale.net>
 <500D19AA.8080006@pengutronix.de>
Message-ID: <20120723105153.GS8265@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:30:18AM +0200, Marc Kleine-Budde wrote:
> On 07/23/2012 11:27 AM, Richard Zhao wrote:
> >> This patch looks like a recipe for disaster IMHO, but it's Alex's call.
> > Well, if there's any better place to hold it, I'd like to move there.
> > Another place is arch/arm/mach-imx. Sascha/Shawn who are maintainers of
> > imx are also in cc list.
> 
> IMHO it's not about the place where the driver is located, it's about
> the shortcomings Michael and Sascha mentioned.

exactly. It's not about where a file is placed or how it's called. It's
how you decided to implement it. This will prevent a platform with
multiple instances of the IP to be used, at least.

Also, if that set of registers are shared, you ought to have a dedicated
driver to handle mutual exclusion and so on. I don't know details about
the i.MX platform, that really smells funny by looking at it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/4dc2b9c6/attachment.sig>

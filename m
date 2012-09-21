From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Sep 2012 09:17:41 +0000
Subject: [GIT PULL RESEND] arm-soc: vt8500: Convert mach-vt8500 to
 devicetree
In-Reply-To: <1348212797.13689.3.camel@gitbox>
References: <1348119906.8199.3.camel@gitbox> <1348209938.1669.4.camel@gitbox>
 <1348212797.13689.3.camel@gitbox>
Message-ID: <201209210917.42388.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 September 2012, Tony Prisk wrote:
> > I plan to submit a new framebuffer driver for 3.8 which could be
> > modified to use the helper when its in 3.8 (assuming it doesn't make
> > 3.7) - or the existing framebuffer driver could be patched to use the
> > of_helper. I realise this creates a bit of churn on the framebuffer
> > code, but more than likely its going to occur anyway if the new driver
> > is accepted.

Slightly unrelated, but what is the state of this driver? I believe
"modern" drivers are supposed to register as a kernel modesetting
driver to the drivers/gpu/drm framwork rather than the traditional
drivers/video infrastructure.

> To clarify, I have made the following changes to try bringing the code
> in line with the videomode_helper patch. I guess this is really a
> question for Rob - Does this help??

>From all I can tell, the vt8500 platform code in the current (v3.6)
version is rather broken due to bitrot, and I think we should take
your code in the fixed version unless Rob has any serious objections.

You have done a great job on cleaning it up and I'd love to see this
all working again in 3.7, even if we have to adapt the bindings
in 3.8.

	Arnd

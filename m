From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Jul 2013 01:03:48 -0700
Subject: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
In-Reply-To: <51DFB139.8060408@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
 <20130712072244.GB7656@atomide.com> <51DFB139.8060408@ti.com>
Message-ID: <20130712080348.GE7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130712 00:39]:
> On Friday 12 July 2013 12:52 PM, Tony Lindgren wrote:
> > * Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
> >> This series should fix the issue with the early serial crash seen
> >> during hwmod _setup() as reported by [1]
> >>
> >> The issue was reported on a am33xx device and was not seen on omap4
> >> or omap5 devices as the hwmod data for both omap4 and omap5 had
> >> statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
> >> uart3 which happens to be the debug console used on omap4 panda and
> >> omap5 uevm boards.
> > 
> > The serial driver should be capable of setting this on it's own
> > as it sets up the console.
> 
> These flags are used to avoid an early reset that hwmod does to all devices
> on the SoC and is done much before serial driver is initialized.

OK so that's only needed for earlycon then it seems.

Regards,

Tony

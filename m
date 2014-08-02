From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Aug 2014 09:21:41 +0100
Subject: [PATCH v8 01/11] ARM: brcmstb: add infrastructure for
 ARM-based Broadcom STB SoCs
In-Reply-To: <CAL_Jsq+47YtqWwOkxYDzaEOG-+oouvpXvmGaX+Wh3wQ+BNAx_w@mail.gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <1405976886-27807-2-git-send-email-computersforpeace@gmail.com>
 <CAL_Jsq+Nbk7m9KXhG+Chdpvurp75RrvhFR2oE_LGxV444GSe9Q@mail.gmail.com>
 <20140731022320.GM3711@ld-irv-0074>
 <CAL_Jsq+47YtqWwOkxYDzaEOG-+oouvpXvmGaX+Wh3wQ+BNAx_w@mail.gmail.com>
Message-ID: <20140802082141.GX30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 09:33:44AM -0500, Rob Herring wrote:
> On Wed, Jul 30, 2014 at 9:23 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> > Like what?
> 
> Errata work-arounds, performance bits, etc. I don't recall exactly
> which ones are per core vs. global. I assume this is an A9, but cores
> with virt extensions would also need to drop to non-secure mode.

The kernel's bringup just before enabling the CPU deals with that stuff
provided your CPU is running in secure mode, but you are right - we /do/
want to encourage platforms to do the errata fixups before they call the
kernel via any entry point.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

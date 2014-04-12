From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Apr 2014 01:24:01 +0100
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
In-Reply-To: <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
References: <53487A9E.70805@ti.com>
 <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
Message-ID: <20140412002401.GS16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 08:13:23PM -0400, Nicolas Pitre wrote:
> On Fri, 11 Apr 2014, Santosh Shilimkar wrote:
> 
> > Russell,
> > 
> > The subject commit breaks Keystone boot with higher address space enabled.
> > I haven't debugged it further but reverting that patch makes it boot again.
> > 
> > I will further look at it on Monday, but thought of letting you know.
> 
> See my comment at the bottom of this email which might be the cause:
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/312721

I still don't see the relevance.  Nothing touches __pv_phys_offset
after we've booted.  From what I can see, this stuff remains incomplete
for Keystone.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

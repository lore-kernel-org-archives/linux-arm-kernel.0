From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Dec 2014 17:28:38 +0000
Subject: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
In-Reply-To: <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna> <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk>
 <54897528.4030804@samsung.com>
 <20141222170411.GL11502@n2100.arm.linux.org.uk>
 <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
Message-ID: <20141222172838.GM11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 11:12:42AM -0600, Nishanth Menon wrote:
> On Mon, Dec 22, 2014 at 11:04 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > That only leaves the non-DT stuff to worry about this, and from what I
> > understand, that's going to be removed soon.  If we're going to keep
> > the non-DT stuff, we should implement a new machine_desc hook for it
> > instead of hijacking one of the existing callbacks.
> 
> none of the PL310 support requires non-DT. PL310 is needed for OMAP4
> and AM437x both of which are DT only.

Right, so the simple answer for the time being is to kill most of
omap_l2_cache_init(), leaving just the ioremap() behind.  Everything
else can go into the machine_desc structures, and OMAP4 and AM437x
can both benefit from initialising the L2 cache at exactly the same
point as most other platforms.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

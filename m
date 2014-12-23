From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 23 Dec 2014 12:00:00 +0100
Subject: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
In-Reply-To: <20141222172838.GM11502@n2100.arm.linux.org.uk>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna> <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk> <54897528.4030804@samsung.com>
 <20141222170411.GL11502@n2100.arm.linux.org.uk>
 <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
 <20141222172838.GM11502@n2100.arm.linux.org.uk>
Message-ID: <54994B30.8040606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-12-22 18:28, Russell King - ARM Linux wrote:
> On Mon, Dec 22, 2014 at 11:12:42AM -0600, Nishanth Menon wrote:
>> On Mon, Dec 22, 2014 at 11:04 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> That only leaves the non-DT stuff to worry about this, and from what I
>>> understand, that's going to be removed soon.  If we're going to keep
>>> the non-DT stuff, we should implement a new machine_desc hook for it
>>> instead of hijacking one of the existing callbacks.
>> none of the PL310 support requires non-DT. PL310 is needed for OMAP4
>> and AM437x both of which are DT only.
> Right, so the simple answer for the time being is to kill most of
> omap_l2_cache_init(), leaving just the ioremap() behind.  Everything
> else can go into the machine_desc structures, and OMAP4 and AM437x
> can both benefit from initialising the L2 cache at exactly the same
> point as most other platforms.

I hope I did it right: https://lkml.org/lkml/2014/12/23/158
Please test, because I have no access to Omap hardware.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

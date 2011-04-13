From: rabin@rab.in (Rabin Vincent)
Date: Wed, 13 Apr 2011 13:17:17 +0530
Subject: [Q] GIC : IRQ_TYPE_LEVEL_LOW interrupts
In-Reply-To: <4DA4A1E2.9090304@ti.com>
References: <4DA4A1E2.9090304@ti.com>
Message-ID: <BANLkTimrxA0-U65Tw208tc1Mqz5ZGa8X9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 00:32, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> As part of the commit 5c0c1f08a (gic: implement set_type)
> change, I see that you are ignoring interrupts which
> are of LOW_LEVEL type. Why is that ?
>
> There are interrupts of LOW_LEVEL type on OMAP and this
> change break those.

Please see the discussion on an earlier, similar patch:
https://patchwork.kernel.org/patch/75509/.  The discussion did
not move further at that time and the "rather easy" solution
mentioned there was implemented.

The GIC spec seems to only talk about rising-edge and active
high:
http://infocenter.arm.com/help/topic/com.arm.doc.ihi0048a/CACCAGCF.html

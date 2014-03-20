From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 20 Mar 2014 20:55:41 +0900
Subject: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
 functions
In-Reply-To: <CANEJEGtK-XfTef3ko+Yq2RNFXohhuQjgamr-DRBmxR-SNzgkJg@mail.gmail.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
 <5322FD14.5090602@samsung.com>
 <20140318185605.0380c8dfe6559c06183092e5@samsung.com>
 <532861BE.7020601@samsung.com>
 <20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
 <532997D7.6090608@samsung.com>
 <CANEJEGtK-XfTef3ko+Yq2RNFXohhuQjgamr-DRBmxR-SNzgkJg@mail.gmail.com>
Message-ID: <20140320205541.d7ef53fd15d9dcd3cadfd13f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Mar 2014 09:54:39 -0700, Grant Grundler wrote:
> On Wed, Mar 19, 2014 at 6:12 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> ...
> >> Device driver is not only for the scholarship but also for the real use.
> >
> > Huh? I'm not sure what kind of comment is this.
> 
> I'm guessing Cho meant: "This isn't an academic exercise - I have a
> real use case that requires reference counting."

That is what I meant; Sorry for my poor English :-)

> Cho needs to be more specific about his "Some driver needs enabling
> sysmmu" example. Then others would understand why/when the reference
> counting is needed. Ie walk through a real driver that exists today
> that depends on reference counting.
>

One of my recent experience is that a display controller (FIMD) driver
of a SoC manages two different context of power management:
One is turning on and off display screen (LCD) (which is as usual as previous SoCs)
and the other is gating its internal clock including System MMU very
frequently to reduce power consumption.
Because System MMU driver holds its clock ungated while it is enabled,
FIMD driver explicitely disable System MMU.

Yes, well designed FIMD driver must care about balancing of
disabling and enabling System MMU between different contexts.
But the design of some complex driver may be poor in few features due to
agressive development schedule sometimes.

Please let me think about the counting.

Now I also think the system mmu driver does not need to make
an extra effort for some special cases.

Regards,

KyongHo

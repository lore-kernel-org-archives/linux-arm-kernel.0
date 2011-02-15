From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 15 Feb 2011 15:59:48 +0200
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
In-Reply-To: <AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
Message-ID: <20110215155948.32b564d5.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011 15:44:27 +0200
David Cohen <dacohen@gmail.com> wrote:

> >> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj,
> >> u32 *ra)
> >> ? ? ? ?da = iommu_read_reg(obj, MMU_FAULT_AD);
> >> ? ? ? ?*ra = da;
> >>
> >> - ? ? ? dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
> >> + ? ? ? dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
> >
> > ? Note that dev_dbg() will only print something if either DEBUG or
> > CONFIG_DYNAMIC_DEBUG are defined...
> 
> That's my plan.
> 
So it's sure that a developer won't need these error dumps when
receiving an error report? I.e. IOMMU upper level errors give enough
information to start doing own debugging?

Just my 2 cents.

-- 
Jarkko

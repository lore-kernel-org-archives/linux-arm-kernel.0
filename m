From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 15 Feb 2011 16:30:27 +0200
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
In-Reply-To: <AANLkTim3+PFgJUU_-YqOt1M5NkSyHo6wUwF_XwC9MWSP@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
	<20110215155948.32b564d5.jhnikula@gmail.com>
	<AANLkTim3+PFgJUU_-YqOt1M5NkSyHo6wUwF_XwC9MWSP@mail.gmail.com>
Message-ID: <20110215163027.c08d0cb1.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011 16:08:32 +0200
David Cohen <dacohen@gmail.com> wrote:

> > So it's sure that a developer won't need these error dumps when
> > receiving an error report? I.e. IOMMU upper level errors give enough
> > information to start doing own debugging?
> 
> Yes, developers do need this information.
> But it's a bit useless tell only we've got an iommu fault, due to many
> places might be causing it. My purpose is to let the debug
> responsibility to IOMMU users. They have access to the iovmm layer as
> well and can provide a much more useful information.
> e.g. OMAP3 ISP has many submodules using IOMMU. With a fault callback,
> it can dump all the iovm areas and the faulty 'da' too. It might
> indicate which submodule was responsible for the issue.
> 
> Of course we can just let this debug messages the way they are and
> print this redundant information. But IMO it's not necessary.
> 
Sounds fair enough and if I understood correctly this is not something
what end user will hit but more like another developer. In that case
the debug messages are the right thing.

-- 
Jarkko

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 15:51:55 +0000
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
In-Reply-To: <AANLkTin=4z0o6=J9f-1mszvGrpaRMgCMk=Ckh5+9j6EQ@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<20110215142923.GC11199@n2100.arm.linux.org.uk>
	<AANLkTin++DGAGT9-nahy1Qm7ASbGm=JjNuPZWZ6XUbcX@mail.gmail.com>
	<20110215144457.GD11199@n2100.arm.linux.org.uk>
	<AANLkTin=4z0o6=J9f-1mszvGrpaRMgCMk=Ckh5+9j6EQ@mail.gmail.com>
Message-ID: <20110215155155.GE11199@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 04:50:29PM +0200, David Cohen wrote:
> That could be my choice.
> I'm not planing to resend this patch, but how good/bad it sounds to
> you to have dev_dbg_cont() for such situation?

That doesn't help when the message gets corrupted by another thread,
so I'd much prefer the "format line then print" approach rather than
the blah_CONT stuff.

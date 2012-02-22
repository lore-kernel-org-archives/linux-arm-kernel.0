From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 09:17:52 +0000
Subject: [PATCH 2/2] iommu/omap: fix NULL pointer dereference
In-Reply-To: <CAK=Wgba1CfpZpDqN3fruL-Ax_a_DwGuB=92pq4Ng3cSUGL8e2Q@mail.gmail.com>
References: <1329900772-9306-1-git-send-email-ohad@wizery.com>
 <1329900772-9306-2-git-send-email-ohad@wizery.com>
 <20120222085623.GF22675@n2100.arm.linux.org.uk>
 <CAK=Wgba1CfpZpDqN3fruL-Ax_a_DwGuB=92pq4Ng3cSUGL8e2Q@mail.gmail.com>
Message-ID: <20120222091752.GG22675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 11:10:38AM +0200, Ohad Ben-Cohen wrote:
> On Wed, Feb 22, 2012 at 10:56 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > There's something else which needs fixing here - the return code. ?If
> > omap_find_iovm_area() returns an error code that needs propagating.
> > Otherwise it might as well just return NULL for all errors.
> 
> Seems like it does just return NULL for all errors, so a cleaner fix
> can probably just be s/IS_ERR(area)/!area/.
> 
> I'll submit it, but Joerg, if you feel this is becoming a "cleanup",
> feel free to take the first version.

That sounds more like a bug fix than a cleanup to me.

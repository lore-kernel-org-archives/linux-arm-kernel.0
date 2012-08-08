From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Aug 2012 16:43:18 +0100
Subject: [PATCH 00/22] Introducing the TI Keystone platform
In-Reply-To: <501E8CEA.9050601@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <20120804083945.GB6802@n2100.arm.linux.org.uk>
 <501E8CEA.9050601@ti.com>
Message-ID: <20120808154318.GE8444@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 04:10:34PM +0100, Cyril Chemparathy wrote:
> On 8/4/2012 4:39 AM, Russell King - ARM Linux wrote:
> > On Tue, Jul 31, 2012 at 07:04:36PM -0400, Cyril Chemparathy wrote:
> >> This series is a follow on to the RFC series posted earlier (archived at [1]).
> >> The major change introduced here is the modification to the kernel patching
> >> mechanism for phys_to_virt/virt_to_phys, in order to support LPAE platforms
> >> that require late patching.  In addition to these changes, we've updated the
> >> series based on feedback from the earlier posting.
> >>
> >> Most of the patches in this series are fixes and extensions to LPAE support on
> >> ARM. The last three patches in this series are specific to the TI Keystone
> >> platform, and are being provided here for the sake of completeness.  These
> >> three patches are dependent on the smpops patch set (see [2]), and are not
> >> ready to be merged in as yet.
> >
> > Can you explain why you want the kernel loaded above the 4GB watermark?
> > This seems silly to me, as the kernel needs to run at points with a 1:1
> > physical to virtual mapping, and you can't do that if the kernel is
> > stored in physical memory above the 4GB watermark.
[...]
> We are well aware of the fact that we are barely scratching the surface 
> of the problem space here, and we'd be very thankful for a heads up on 
> issues that we may have missed so far.

Another thing to be aware is that apart from a virtual alias between the
kernel mapping and the idmap, you now introduce a physical alias as well
and the caches (physically tagged) get confused.

-- 
Catalin

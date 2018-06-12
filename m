From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 17:09:18 -0500
Subject: [RFC PATCH 1/3] Documentation: dt: keystone: ti-sci: Add
 optional host-id parameter
In-Reply-To: <20180612213922.GA26791@rob-hp-laptop>
References: <20180605062640.3356-1-nm@ti.com> <20180605062640.3356-2-nm@ti.com>
 <20180612213922.GA26791@rob-hp-laptop>
Message-ID: <20180612220918.7cchihtcmmta6pm5@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:39-20180612, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:26:38AM -0500, Nishanth Menon wrote:
> > Texas Instrument's System Control Interface (TISCI) permits the
> > ability for Operating Systems to running in virtual machines to be
> 
> ...for OSs running in virtual...

Ack. thanks.

> 
> > able to independently communicate with the firmware without the need
> > going through an hypervisor.
> > 
> > The "host-id" in effect is the hardware representation of the
> > host (example: VMs locked to a core) as identified to the System
> > Controller.
> 
> So the hypervisor will fill in host-id's for each VM instance?

Yes OR have it's own device tree blobs representation of it's own host
IDs assigned by system firmware. This provides complete independence of
VMs to communicate with the system controller (once the host-id is
provided) without switching to hyp for arbitration (and yes, verified
ability with jailhouse hypervisor and multiple linux instances operating
simultaneously). This also has the added benefit of:
1. The burden of hypervisor from being involved in PM functionality as each
of the VMs can operate autonomously.
2. In TI SoCs which are heterogeneous, the system firmware plays the role
of system master communicating with multiple firmware(running on various
uCs) and OSes running on bigger cores.

-- 
Regards,
Nishanth Menon

From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 16 Jun 2011 11:44:30 +0200
Subject: [RFC] Add Arm cpu topology definition
In-Reply-To: <20110616085547.GH4935@const.famille.thibault.fr>
References: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
	<20110616085547.GH4935@const.famille.thibault.fr>
Message-ID: <BANLkTinxz1T7uPAS0u=gth3hAh+SFQkTQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2011 10:55, Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> Hello,
>
> Vincent Guittot, le Thu 16 Jun 2011 10:49:13 +0200, a ?crit :
>> The affinity between Arm processors is defined in the MPIDR register.
>> We can identify which processors are in the same cluster,
>> and which ones have performance interdependency. The cpu topology
>> ?of an Arm platform can be set thanks to this register and this topology
>> is then used by sched_mc and sched_smt.
>
> Cool! ?Could you check that the hwloc tool gets also gets this
> information from userland through /sys, and/or send me the output of the
> hwloc-gather-topology tool from hwloc so we can add an testcase for
> this?
>

The output of hwloc-gather-topology is :

Machine (phys=0 local=280840KB total=280840KB)
  Socket #0 (phys=3)
    Core #0 (phys=0)
      PU #0 (phys=0)
    Core #1 (phys=1)
      PU #1 (phys=1)
depth 0:        1 Machine (type #1)
 depth 1:       1 Socket (type #3)
  depth 2:      2 Cores (type #5)
   depth 3:     2 PUs (type #6)
Topology not from this system

let me know if it's what you want

> Samuel
>

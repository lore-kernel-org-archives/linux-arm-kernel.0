From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Mon, 13 Nov 2017 19:40:46 +0100
Subject: RCU stall with high number of KVM vcpus
In-Reply-To: <7dda7be2-f392-8056-d4d3-372bb867729a@arm.com>
References: <20171113131000.GA10546@hc>
 <2832f775-3cbe-d984-fe4f-e018642b6f1d@arm.com>
 <20171113173552.GA13282@hc>
 <7dda7be2-f392-8056-d4d3-372bb867729a@arm.com>
Message-ID: <20171113184046.GA14678@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 06:11:19PM +0000, Marc Zyngier wrote:
> On 13/11/17 17:35, Jan Glauber wrote:
> > On Mon, Nov 13, 2017 at 01:47:38PM +0000, Marc Zyngier wrote:

[...]

> >> Please elaborate. Messed in what way? Corrupted? The guest crashing? Or
> >> is that a tooling issue?
> > 
> > Every vcpu that oopses prints one line in parallel, so I get blocks like:
> > [58880.179814] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.179834] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.179847] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.179873] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.179893] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.179911] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.179917] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180288] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180303] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180336] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180363] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180384] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180415] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > [58880.180461] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> > 
> > I can send the full log if you want to have a look.
> 
> Sure, send that over (maybe not over email though).

Here is the guest dmesg:
http://paste.ubuntu.com/25955682/

And the host dmesg as it might have been too big for the lists:
http://paste.ubuntu.com/25955699/



> Can you send me your kernel configuration as well? I wonder if we're not
> seeing interactions with things like KSM and the like...

It was plain arm64 defconfig but I disabled
HAVE_KVM_CPU_RELAX_INTERCEPT. Not that it had an impact, just tried.

http://paste.ubuntu.com/25955726/

--Jan

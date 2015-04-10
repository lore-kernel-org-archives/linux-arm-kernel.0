From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Apr 2015 17:07:20 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <AF65C7BF-CBBD-4E03-95AA-495830D6DC20@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410110328.GC25921@red-moon>
 <AF65C7BF-CBBD-4E03-95AA-495830D6DC20@codeaurora.org>
Message-ID: <20150410160720.GC17828@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 04:25:54PM +0100, Kumar Gala wrote:
> 
> On Apr 10, 2015, at 6:03 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Thu, Apr 09, 2015 at 06:37:06PM +0100, Kumar Gala wrote:
> >> This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.
> >> 
> >> To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
> >> setup the boot/release addresses for the secondary CPUs.  In addition we need
> >> a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
> >> CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
> >> firmware that does not support those methods.
> > 
> > Why ? Do not tell me you were not aware of those standard methods,
> > because I can't believe you.
> > 
> > If there were additional features to add to spin-table and PSCI,
> > you were, you are and you will always be welcome to debate them.
> > 
> > There is no justification for this patchset, honestly.
> > 
> > Lorenzo
> 
> The justification for this patchset is support for a hardware platform that exists in the world.  The kernel usual is willing to accept such things as long as the code is reasonable.

You are telling me you add a linker section for cpu_ops just for
"a platform that exists", sorry I do not believe that (and that's *not*
reasonable).

I do not like this line of reasoning, at all, because you were aware of
PSCI and ignored it, deliberately. Start by pushing code for platforms
upstream that support PSCI, "they are coming up next" does not cut it.

I can see power management mach code coming next, just no way.

Implement PSCI and the kernel will be willing to accept it, as it stands
as far as I am concerned that's a NAK on the series.

Lorenzo

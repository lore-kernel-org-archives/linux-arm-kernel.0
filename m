From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Oct 2015 14:03:47 +0100
Subject: [PATCH v2] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20151006173152.GA15091@red-moon>
References: <1441906822-9222-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20151006165049.GE3069@e104818-lin.cambridge.arm.com>
 <1444151732.10788.13.camel@redhat.com>
 <20151006173152.GA15091@red-moon>
Message-ID: <20151007130347.GB875@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 06:31:52PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 06, 2015 at 01:15:32PM -0400, Mark Salter wrote:
> > On Tue, 2015-10-06 at 17:50 +0100, Catalin Marinas wrote:
> > > Question to Lorenzo and Mark Salter: was this patch successfully tested
> > > on real hardware (like Applied X-Gene)?
> > 
> > It doesn't work on X-Gene/Mustang because the existing firmware
> > implementations are not exactly compliant with the parking protocol
> > spec. I've been hacking on the firmware trying to get something
> > which will work wrt the spec but keep getting distracted by other
> > things.
> 
> I tested the code on AMD Supercharger even though I had to change
> the remap implementation since the existing firmware uses cacheable
> mappings for the mailboxes.
> 
> I put it together to make sure that it is there if any platform
> compliant with it relies on it and more importantly to prevent
> non-compliant implentations from trickling into the kernel,
> basically to prevent broken firmware implementations from being
> considered compliant and "working".

That's a good point. However, AFAIK, AMD are using PSCI already in their
firmware implementation and that's what we recommend anyway if EL3 is
available.

So this patch is mainly aimed at X-Gene since other implementations I'm
aware of have EL3 already. What are the chances of Applied Micro fixing
their firmware and actually using this patch? (not a question for you;
I'm hoping some Applied engineers would comment).

-- 
Catalin

From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 2 Dec 2016 10:21:01 -0600
Subject: ACPI namespace details for ARM64
In-Reply-To: <1d7424da-f9f8-68e3-5571-b9fc46f13a7f@redhat.com>
References: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
 <1d7424da-f9f8-68e3-5571-b9fc46f13a7f@redhat.com>
Message-ID: <20161202162101.GA9903@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 11:52:00PM -0500, Jon Masters wrote:
> On 11/09/2016 05:05 PM, Bjorn Helgaas wrote:

> > The basic requirement is that the ACPI namespace should describe
> > *everything* that consumes address space unless there's another
> > standard way for the OS to find it [1, 2].
> 
> ...and by the way, this was a key lesson for me, too. I had not
> fully internalized before that you don't just want to describe the
> ECAM region in the MCFG but you also need to ensure it's properly
> described in the ACPI namespace. Lots of good things learned.

I wish the ACPI spec contained explicit language to this effect, but
if it does, I haven't found it.  There might be firmware people who
would disagree with it.

My rationale is that the OS may receive a device with no address
space assigned, and for the OS to safely assign space, it has to know
everything to avoid.  The devil's advocate might argue that the OS
doesn't need full knowledge as long as firmware constrains every
device's _PRS to avoid the possibility of conflict.  But that seems
like it would be impractical for non-trivial systems.

Bjorn

From: alex.williamson@redhat.com (Alex Williamson)
Date: Tue, 11 Jun 2013 08:52:06 -0600
Subject: [PATCH 2/2] add initial kvm dev passhtrough support
In-Reply-To: <51B73095.3070408@huawei.com>
References: <51B6D52E.4030707@huawei.com>
 <A501B176-B65B-4CEB-BB12-3EE7C165945C@suse.de>
 <51B73095.3070408@huawei.com>
Message-ID: <1370962326.6598.10.camel@ul30vt.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-06-11 at 16:13 +0200, Mario Smarduch wrote:
> On 6/11/2013 10:28 AM, Alexander Graf wrote:
> 
> > 
> > Is there any particular reason you're not going down that path for your ARM implementation?
> 
> We see this as a good starting point to build on, we need baseline numbers
> for performance, latency, interrupt throughput on real hardware
> ASAP to build competency for NFV, which has demanding Dev. Passthrough
> requirements. Over time we plan contributing to SMMU and VFIO as well
> (we're looking into this now).
> 
> FYI NFV is an initiative wireless/fixed network operators are working 
> towards - to virtualize Core, likely Radia Access and even Home Network 
> equipment, this is a epic undertaking (i.e. Network Function Virtualization). 
> So far VMware has taken the lead (mostly x86).
>  
> > 
> > On the embedded PPC side we've been discussing vfio and how it fits into a device tree, non-PCI world for a while. If you like, we can dive into more detail on that, either via email or via phone.
> 
> I'll email you offline, I'd like to know more what you've done on this
> and see where we can align/leverage the effort.

Yes, please let's use VFIO rather than continue to use or invent new
device assignment interfaces for KVM.  Antonios Motakis (cc'd) already
contacted me about VFIO for ARM.  IIRC, his initial impression was that
the IOMMU backend was almost entirely reusable for ARM (a couple PCI
assumptions implicit in the IOMMU API to handle) and my hope was that
ARM and PPC could work together on a common VFIO device tree backend.
Thanks,

Alex

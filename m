From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 7 Sep 2015 19:05:16 +0100
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <55EA1C3F.1030300@caviumnetworks.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <55B5E8C1.4030707@arm.com> <55EA1C3F.1030300@caviumnetworks.com>
Message-ID: <20150907180516.GC18079@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 11:33:35PM +0100, David Daney wrote:
> Hi Mark,

Hi David,

> I now have a prototype implementation for irq-gic-v3-its.c that is using 
> this binding on Cavium's ThunderX platform.
> 
> Q: Have you guys had any more thoughts on this that might require 
> changing the binding?

Having discussed this with Stuart and others at Linux Plumbers, I think
that the binding is sufficient, and unlikely to change greatly unless
there is a strong objection (Stuart, please correct me if I am wrong).

Per Marc's comments there are probably some edge cases and/or wording
details to sort out, but I think the common/simple case is sorted. I'll
send a v2 once those have been settled.

> If not, I will be sending out my patches for your consideration.

Please do!

> Thanks,
> David Daney
> 
> On 07/27/2015 01:16 AM, Marc Zyngier wrote:
> > On 23/07/15 17:52, Mark Rutland wrote:
> >> Currently msi-parent is used by a few bindings to describe the
> >> relationship between a PCI root complex and a single MSI controller, but
> >> this property does not have a generic binding document.
> >>
> >> Additionally, msi-parent is insufficient to describe more complex
> >> relationships between MSI controllers and devices under a root complex,
> >> where devices may be able to target multiple MSI controllers, or where
> >> MSI controllers use (non-probeable) sideband information to distinguish
> >> devices.
> >>
> >> This patch adds a generic binding for mapping PCI devices to MSI
> >> controllers. This document covers msi-parent, and a new msi-map property
> >> (specific to PCI*) which may be used to map devices (identified by their
> >> Requester ID) to sideband data for each MSI controller that they may
> >> target.
> >>
> >> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Acked-by: David Daney <david.daney@cavium.com>

Thanks!

Mark.

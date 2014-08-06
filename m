From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Aug 2014 10:58:37 -0600
Subject: [PATCH] PCI: keystone: add a pci quirk to limit mrrs
In-Reply-To: <53E25E24.8070506@ti.com>
References: <1407338300-9146-1-git-send-email-m-karicheri2@ti.com>
 <20140806163021.GB19914@obsidianresearch.com>
 <53E25E24.8070506@ti.com>
Message-ID: <20140806165837.GC19914@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 12:56:04PM -0400, Murali Karicheri wrote:
> On 08/06/2014 12:30 PM, Jason Gunthorpe wrote:
> >On Wed, Aug 06, 2014 at 11:18:20AM -0400, Murali Karicheri wrote:
> >>Keystone PCI controller has a limitation that memory read request
> >>size must not exceed 256 bytes. This is a hardware limitation and
> >>add a quirk to force this limit on all downstream devices by
> >>updating mrrs.
> >
> >Does this still work if the tuning is enabled, or does the tuning run
> >after this?
> 
> Yes it works with tuning enabled. Tuning happens afterwards. The
> 'limiting mrrs to 256' below is from my patch.

That seems backwards to me...

Jason

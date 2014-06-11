From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Jun 2014 14:04:52 +0200
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CACxGe6vzGrNxqdanhUX3G-dvN-jVrX9YQyOA==h0Vnv_sf-aTA@mail.gmail.com>
References: <20140328184517.GA27219@cbox> <5397360B.80102@huawei.com>
 <alpine.DEB.2.02.1406111035190.13771@kaball.uk.xensource.com>
 <20140611095540.GD24286@lvm>
 <CACxGe6vzGrNxqdanhUX3G-dvN-jVrX9YQyOA==h0Vnv_sf-aTA@mail.gmail.com>
Message-ID: <20140611120452.GE24286@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 12:28:40PM +0100, Grant Likely wrote:
> On Wed, Jun 11, 2014 at 10:55 AM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > Agree with what Stefano says, and I strongly recommend you reconsider
> > your position on FDT vs. ACPI for ARM VMs, but it's completely up to
> > you of course :)
> 
> Not entirely. 

of course it's up to them what they want to do.

> The plan right now is to only support ACPI when booting
> with UEFI. If they don't use UEFI, then ACPI will not be available. If
> OSv only supports ACPI, then it is forced to use the UEFI boot path.
> 
The plan right now is to not support ACPI in VMs at all, as per the last
discussion at LCA14.  If an when someone wants to add that, fine, but
the spec mandates FDT describing the full system.

If OSv wants to hack a KVM implementation or provide a static ACPI blob
coupled to OSv that happens to describe the KVM/ARM/QEMU system model,
then they can do that.  Crazy, it sounds to me, but as I said, up to the
OSv guys.

-Christoffer

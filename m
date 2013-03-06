From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 6 Mar 2013 14:29:44 +0100
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <alpine.LFD.2.02.1303051114370.22263@ionos>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
 <1311295758-27493-1-git-send-email-simon@sequanux.org>
 <CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
 <20110726153930.GG16297@kw.sim.vm.gnt>
 <CAMAG_ee8YBvDsdQ2zNfn-7qdyTmVYBVb8xykMMv4pg8tEswJgg@mail.gmail.com>
 <5134AF7E.5010605@keymile.com>
 <20130304154454.GG21620@kw.sim.vm.gnt>
 <alpine.LFD.2.02.1303051114370.22263@ionos>
Message-ID: <20130306132944.GJ21620@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 11:15:04AM +0100, Thomas Gleixner wrote:
> On Mon, 4 Mar 2013, Simon Guinot wrote:
> > On Mon, Mar 04, 2013 at 03:28:14PM +0100, Gerlando Falauto wrote:
> > 
> > AFAIK this issue is still here. I include the current Orion maintainers
> > in the Cc list.
> 
> Can you please resend the patch?

Hi Thomas,

Do you agree with the original patch concept: moving mask_cache from
struct irq_chip_generic into struct irq_chip_type ?

This allows to handle the irq_chips which have separate mask registers
for the edge and level interrupts. At the time of this patch, this was
the only existing case.

Saeed objected that the patch was not correct because this was breaking
"hypothetic" devices with multiple irq_chip_type and a single mask
register.

The other option was to provide some dedicated irq_mask handlers for the
Orion irq chip.

As I was comfortable with none of this solutions, I kind of let it lie.

Let me know you advice.

Simon

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/014a76f1/attachment.sig>

From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 18 Apr 2015 14:37:25 +0200
Subject: [PATCH v2 2/2] arch: arm: Show the serial number from
 devicetree in cpuinfo
In-Reply-To: <20150418122758.GJ12732@n2100.arm.linux.org.uk>
References: <1429296235-14123-1-git-send-email-contact@paulk.fr>
 <1429296235-14123-2-git-send-email-contact@paulk.fr>
 <20150418091310.GI12732@n2100.arm.linux.org.uk>
 <1429350313.2424.1.camel@collins>
 <20150418122758.GJ12732@n2100.arm.linux.org.uk>
Message-ID: <1429360645.2424.4.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le samedi 18 avril 2015 ? 13:27 +0100, Russell King - ARM Linux a
?crit :
> On Sat, Apr 18, 2015 at 11:45:13AM +0200, Paul Kocialkowski wrote:
> > Le samedi 18 avril 2015 ? 10:13 +0100, Russell King - ARM Linux a
> > ?crit :
> > > Hi,
> > > 
> > > On Fri, Apr 17, 2015 at 08:43:55PM +0200, Paul Kocialkowski wrote:
> > > >  static int __init init_machine_late(void)
> > > >  {
> > > > +#ifdef CONFIG_OF
> > > > +	unsigned long dt_root;
> > > > +	int size;
> > > > +
> > > > +	dt_root = of_get_flat_dt_root();
> > > > +
> > > > +	/* Scan for serial number */
> > > > +	system_serial = of_get_flat_dt_prop(dt_root, "serial-number", &size);
> > > 
> > > I was really hoping for:
> > > 
> > > 	if (of_property_read_string(of_root, "serial-number", &system_serial))
> > > 		system_serial = NULL;
> > > 
> > > here.  I can't see a reason to use the flattened DT at this point as
> > > we've already parsed it.
> > 
> > Good point -- I'm not very used to using device-tree so I didn't think
> > of it, thanks for mentioning it.
> > 
> > At this point, I guess I can also add your Signed-Off-By to the patch.
> 
> No - Signed-off-by is to indicate the path by which it was committed
> into the git tree, not for review, etc.

Right, but since you've provided me with code samples, you might as well
hold part of the authorship of the patch.

> I'm assuming you'll be submitting this to my patch system eventually,
> which means when I apply the patch, it'll have my S-o-b automatically
> added.

V3 (that includes your suggestion) was sent already.

Thanks for the review and comprehensive help!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/0197a35a/attachment.sig>

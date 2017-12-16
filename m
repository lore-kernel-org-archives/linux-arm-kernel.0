From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Sat, 16 Dec 2017 13:50:59 +0100
Subject: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806
 and CP110
In-Reply-To: <20171215232854.n23biqelqoqjsevm@rob-hp-laptop>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-2-miquel.raynal@free-electrons.com>
 <20171215082759.7t24ka3lpkulcb7r@tarshish>
 <20171215093203.74b7a59c@xps13> <87po7gmlcs.fsf@free-electrons.com>
 <20171215115230.6fb83cb6@xps13>
 <20171215232854.n23biqelqoqjsevm@rob-hp-laptop>
Message-ID: <20171216135059.059bc00a@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

On Fri, 15 Dec 2017 17:28:54 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Dec 15, 2017 at 11:52:30AM +0100, Miquel RAYNAL wrote:
> > Hello Baruch and Gregory,
> > 
> > On Fri, 15 Dec 2017 09:44:19 +0100
> > Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> >   
> > > Hi Miquel,
> > >  
> > >  On ven., d?c. 15 2017, Miquel RAYNAL
> > > <miquel.raynal@free-electrons.com> wrote:
> > >   
> > > > Hello Baruch,
> > > >
> > > > On Fri, 15 Dec 2017 10:27:59 +0200
> > > > Baruch Siach <baruch@tkos.co.il> wrote:
> > > >    
> > > >> Hi Miquel
> > > >> 
> > > >> On Thu, Dec 14, 2017 at 11:30:01AM +0100, Miquel Raynal
> > > >> wrote:    
> > > >> > +- marvell,thermal-zone-name: The name to identify the
> > > >> > thermal zone
> > > >> > +                             within the sysfs, useful when
> > > >> > multiple
> > > >> > +                             thermal zones are registered
> > > >> > (AP, CPx...).      
> > > >> 
> > > >> I don't think that would be acceptable. DT is about describing
> > > >> the hardware. sysfs is a Linux implementation detail which is
> > > >> not tied to any specific hardware. If this is accepted, the
> > > >> property should be named 'linux,thermal-zone-name'.    
> > > >
> > > > You are right the sysfs mention should not appear in the
> > > > description.  
> > 
> > Actually, you are right for all of it, this property should not
> > exist, sorry for my too quick answer.
> >   
> > > >
> > > > Otherwise for the naming I'm not sure "linux," is a valid
> > > > prefix in that case.    
> > 
> > Thank you both for your explanations, I was also wrong about the
> > prefix. 
> > > 
> > > Actually the choice between linux or marvell make me realize that
> > > there is something wrong. Having a name associated to a device is
> > > something pretty usual with the device tree, however it is as the
> > > class device level, such as clock-names, line-name, or
> > > regulator-name. So in my opinion if we want to support naming from
> > > device tree it would be done for all the thermal device not just
> > > for the Marvell one.
> > > 
> > > However I don't think we need it. For example for the clocks we
> > > created the name dynamically using of the base address of the
> > > register to keep them unique.  
> > 
> > I was convinced that dev_name's would be the same but after trying
> > it on a 8040-DB, using dev_name(&pdev->dev) gives:
> > 
> >     f06f808c.thermal
> >     f2400078.thermal
> >     f4400078.thermal
> > 
> > which I found meaningful enough.
> > 
> > I will drop the property and use dev_name instead. I still need your
> > help to solve one problem though: how to make the distinction
> > between using "armada_thermal" (the previous name) and dev_name() ?
> > If I don't it kind of breaks userspace, doesn't it ?  
> 
> No. The /sys/devices/... or /sys/bus/platform/... paths and names are 
> not guaranteed to be stable. These changed for every platform
> converted to DT for example. Userspace should be accessing things
> through /sys/class/... (or deal with changes).

Ok, thanks for the explanation.

I will sent a v4 early next week about all the changes requested.

Thank you all for reviewing.
Miqu?l

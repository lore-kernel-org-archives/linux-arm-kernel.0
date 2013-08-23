From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Aug 2013 10:04:40 +0200
Subject: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
In-Reply-To: <1522215.zHEjdiga8V@flatron>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
 <1522215.zHEjdiga8V@flatron>
Message-ID: <20130823080439.GE3535@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 10:25:30AM +0200, Tomasz Figa wrote:
> On Thursday 22 of August 2013 02:55:42 Xiubo Li-B47053 wrote:
> > Hi Tomasz,
> > 
> > Thanks for your comments.
> > 
> > > > +- #pwm-cells: Should be 3. Number of cells being used to specify
> > > > PWM
> > > > property.
> > > > +  First cell specifies the per-chip channel index of the PWM
> > > > to use, the
> > > > +  second cell is the period in nanoseconds and bit 0 in
> > > > the third cell is
> > > > +  used to encode the polarity of PWM output. Set bit
> > > > 0 of the third in PWM
> > > > +  specifier to 1 for inverse polarity & set to 0
> > > > for normal polarity.
> > > 
> > > If the meaning of flags cell is the same as in generic, default PWM
> > > specifier format, then it should be noted here and generic PWM binding
> > > documentation mentioned.
> > 
> > OK, How about the following ?
> > - #pwm-cells: Should be 3. See pwm.txt in this directory for a
> >   description of the cells format.
> 
> I meant just the last cell, which stores flags, but actually this might be 
> a good idea, but with slightly extended description. Something among those 
> lines:
> 
>  - #pwm-cells: Should be 3. The default three cell format specified by 
> generic PWM bindings are used. Refer to the documentation of generic PWM 
> bindings for more information about the meaning of cells.

Actually I prefer the second proposal, that is:

> > - #pwm-cells: Should be 3. See pwm.txt in this directory for a
> >   description of the cells format.

We agreed on that wording in another thread and I'd prefer to be
consistent across bindings.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/bb8945cd/attachment.sig>

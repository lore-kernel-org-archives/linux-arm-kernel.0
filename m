From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sat, 22 Nov 2014 08:06:45 -0800
Subject: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify DT
 params
In-Reply-To: <1416555331.28873.8.camel@mm-sol.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
 <1416300621.30131.6.camel@mm-sol.com>
 <995406b8e0244c63a3ef8e58314e81f6@BL2FFO11FD037.protection.gbl>
 <1416383379.30131.14.camel@mm-sol.com>
 <84517404cda34124930ec838a639f538@BL2FFO11FD030.protection.gbl>
 <1416470777.28873.1.camel@mm-sol.com>
 <7e2f4984733343fdb4ea51cf7eb4c339@BY2FFO11FD046.protection.gbl>
 <1416555331.28873.8.camel@mm-sol.com>
Message-ID: <0c3dad3ce852435fba127e8436f0e30f@BN1BFFO11FD047.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On Fri, 2014-11-21 at 09:35AM +0200, Ivan T. Ivanov wrote:
> 
> On Thu, 2014-11-20 at 08:22 -0800, S?ren Brinkmann wrote:
> > 
> > 
> > Also, I hope all my changes here don't break the current behavior. So,
> > those 27 driver should still be able to do what they currently do. But I
> > hope they could migrated over to use the generic bindings only in the
> > longer term, so that these custom properties disappear.
> > 
> > > > The pinctrl driver just assembles
> > > > some data structure that has the information regarding custom properties
> > > > and the core handles the rest.
> > > 
> > > Yup, that is nice. What will be really nice if it also handle custom,
> > > "function", "groups" and "pins" properties. Otherwise most of the drivers
> > > will not be able to benefit from this.
> > 
> > Why would you still need those? 
> 
> I don't need them :-). The point was that still majority of the drivers
> will have custom parsing functions. It would be nice if we could fix
> that too. I do understand that using custom "pins", "functions"... is
> something which is deprecated, but if core parsing functions allow
> passing custom strings for above purposes, in a similar way as your
> proposal, it will be easier for those drivers to migrate, I believe.

This does sound much more like a feature request than a fundamental
problem with the implementation, now. And like Laurent's feature
request, I'd like to turn this down. Otherwise this just gets hold up by
feature requests blocking pinctrl-zynq.
I think the interesting questions are:
1. Does it break any current user?
2. Is there anything fundamentally preventing adding your feature at
some later time as part of such a migration you describe?

	Thanks,
	S?ren

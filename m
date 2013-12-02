From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Dec 2013 11:37:20 +0000
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <20131117182852.GC30012@xo-6d-61-c0.localdomain>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
 <20131112153057.GA9683@earth.universe>
 <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
 <20131112200514.GA15413@earth.universe>
 <CACRpkdaAaLjm_b+OLj3tobxBN8YGUcTPnXJ=qtBqd02=FTxhjQ@mail.gmail.com>
 <20131112204013.GA17674@earth.universe>
 <20131113142406.GH21713@e106331-lin.cambridge.arm.com>
 <20131117182852.GC30012@xo-6d-61-c0.localdomain>
Message-ID: <20131202113720.GF12952@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 17, 2013 at 06:28:52PM +0000, Pavel Machek wrote:
> 
> > > Thus I guess we should not use the name, which has the most adopters
> > > in kernel (or out of kernel). Instead the most fitting name should
> > > be used. Current suggestions (taken from kernel) are:
> > > 
> > > * <<vendor>>,no-autorepeat
> > > * keypad,autorepeat
> > > * linux,keypad-no-autorepeat
> > > * linux,input-no-autorepeat
> > > * linux,no-autorepeat
> > > * autorepeat
> > > 
> > > I do not really care, which one is chosen, except for two things:
> > > 
> > > * <<vendor>> seems wrong. This is not vendor specific.
> > > * I would prefer "input-" over "keypad-", since then the same name
> > >   can be used for single keys, buttons, etc.
> > 
> > Both of those sound valid to me, but I think it may make sense to keep
> > the "linux," prefix. As I understand it this is really telling the Linux
> > input subsystem to react to a device acting in a certain way, rather
> > than describing or configuring the device in a certain way.
> 
> I'd say it is very much configuring device in certain way, and yes, other
> operating systems will want to do autorepeat, too.

Nothing is handled differently at the device with respect to this flag.
The Linux input subsystem behaves differently. Thus this is
configuration of the Linux input subsysytem, not the device.

> 
> I believe we don't want to end up with
> 
> linux,input-no-autorepeat
> bsd,keypad-autorepeat
> windows-phone,disable-autorepeat

I do not see a problem with this. This is only as bad as the current
situation, but has the benefit that the madness is constrained to
particular vendor prefixes, which we can uniquely identify and handle
differently if required.

> 
> ...and should avoid linux, prefix.

I disagree.

Mark.

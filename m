From: sre@ring0.de (Sebastian Reichel)
Date: Sun, 17 Nov 2013 19:03:30 +0000
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <20131117182845.GB30012@xo-6d-61-c0.localdomain>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
 <20131112153057.GA9683@earth.universe>
 <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
 <20131112200514.GA15413@earth.universe>
 <CACRpkdaAaLjm_b+OLj3tobxBN8YGUcTPnXJ=qtBqd02=FTxhjQ@mail.gmail.com>
 <20131112204013.GA17674@earth.universe>
 <20131117182845.GB30012@xo-6d-61-c0.localdomain>
Message-ID: <20131117190330.GA21421@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 17, 2013 at 07:28:45PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > I could find two boards using "gpio-matrix-keypad" in the mainline
> > > > kernel and not a single instance of "linux,no-autorepeat":
> > > 
> > > In things connected to GPIO, I don't expect the in-kernel
> > > device trees to be a good way so survey the usage of these
> > > bindings. Anyone doing device trees on any system with a
> > > few GPIOs can be using this.
> > > 
> > > But maybe we're lucky and won't break anyone's setup if
> > > we change this?
> > 
> > AFAIK Device Tree property names are considered as ABI, so existing
> > property names must not be removed.
> > 
> > But I guess we can add the standardized property name in addition
> > to the deprecated one. New drivers can use the standardized property
> > name from the beginning.
> > 
> > Thus I guess we should not use the name, which has the most adopters
> > in kernel (or out of kernel). Instead the most fitting name should
> > be used. Current suggestions (taken from kernel) are:
> > 
> > * <<vendor>>,no-autorepeat
> > * keypad,autorepeat
> > * linux,keypad-no-autorepeat
> > * linux,input-no-autorepeat
> > * linux,no-autorepeat
> > * autorepeat
> > 
> > I do not really care, which one is chosen, except for two things:
> > 
> > * <<vendor>> seems wrong. This is not vendor specific.
> > * I would prefer "input-" over "keypad-", since then the same name
> >   can be used for single keys, buttons, etc.
> 
> Hmm, and it is not Linux-specific, either. So can we stick with simple "autorepeat"?

The advantage of the negated form is, that autorepeat is enabled by
default. So what do you think about

input-no-autorepeat

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131117/84d641b8/attachment.sig>

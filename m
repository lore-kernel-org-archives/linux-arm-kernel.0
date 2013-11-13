From: sre@ring0.de (Sebastian Reichel)
Date: Thu, 14 Nov 2013 00:29:24 +0100
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <20131113142406.GH21713@e106331-lin.cambridge.arm.com>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
 <20131112153057.GA9683@earth.universe>
 <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
 <20131112200514.GA15413@earth.universe>
 <CACRpkdaAaLjm_b+OLj3tobxBN8YGUcTPnXJ=qtBqd02=FTxhjQ@mail.gmail.com>
 <20131112204013.GA17674@earth.universe>
 <20131113142406.GH21713@e106331-lin.cambridge.arm.com>
Message-ID: <20131113232923.GB13669@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 13, 2013 at 02:24:06PM +0000, Mark Rutland wrote:
> > Current suggestions (taken from kernel) are:
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
> Both of those sound valid to me, but I think it may make sense to keep
> the "linux," prefix. As I understand it this is really telling the Linux
> input subsystem to react to a device acting in a certain way, rather
> than describing or configuring the device in a certain way.

That leaves the following two options:

* linux,input-no-autorepeat
* linux,no-autorepeat

Any suggestions for those?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/bb218d1c/attachment.sig>

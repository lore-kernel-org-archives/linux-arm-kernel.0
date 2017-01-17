From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Jan 2017 08:20:34 +1100
Subject: [PATCH v2 03/10] dt-bindings: sound: Add new reset compatible
 for sun4i-i2s
In-Reply-To: <20170117201016.A5fiHT0P@smtp2p.mail.yandex.net>
References: <20170117201016.A5fiHT0P@smtp2p.mail.yandex.net>
Message-ID: <20170118082034.62a6be25@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 18 Jan 2017 01:10:00 +0800, Icenowy Zheng wrote:

> > Add a new compatible for sun4i-i2s driver to handle some
> > SoCs that have a reset line that must be asserted/deasserted.
> >
> > This new compatible, "allwinner,sun6i-a31-i2s", requires two
> > properties:
> > - resets: phandle to the reset line
> > - reset-names: the name of the reset line ("rst").
> > Except these differences, the compatible is identical to previous one
> > which will not handle a reset line.  
> 
> But I think the IP block is identical, right?
> 
> Should a new compatible be added only for reset-line?

Having a different compatible in this case allows to make some stricter
error checking: the driver can make sure that if the compatible string
is sun6i-a31-i2s there *IS* a reset line specified in the DT. Without a
separate compatible value, such a check is not possible, and the reset
line is just optional. This can lead to people being confused if they
forget to specify the reset line.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

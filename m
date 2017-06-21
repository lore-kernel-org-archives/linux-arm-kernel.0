From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Jun 2017 17:13:21 +0100
Subject: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver
In-Reply-To: <20170621160340.GE3372@dragon>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
 <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
 <20170620031953.GC4818@x250>
 <20170620124059.r55r363y3y3if6jg@sirena.org.uk>
 <20170621160340.GE3372@dragon>
Message-ID: <20170621161321.mstpidbyq55q4mmj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 12:03:41AM +0800, Shawn Guo wrote:
> On Tue, Jun 20, 2017 at 01:40:59PM +0100, Mark Brown wrote:

> > Sounds like a fairly standard use for a supply widget.

> Yes, it can be a supply widget.  But it's a bit that controls device
> overall power rather than any particular component power.  Since every
> single operation of the device will need this power bit to be on, I
> think it makes sense to configure the bit in .startup/.shutdown hooks,
> rather than creating a widget for it and attaches the widget to a bunch
> of components.

Do it with DAPM - this means any analogue paths will work and there's no
possibility of refcounting issues.  You will need to create a bunch of
links but that's pretty easy and it's all data rather than code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/0d62222a/attachment.sig>

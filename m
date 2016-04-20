From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Apr 2016 17:11:22 +0100
Subject: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <1461145190.3774.5.camel@mtksdaap41>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
 <20160420082917.GH3217@sirena.org.uk>
 <1461145190.3774.5.camel@mtksdaap41>
Message-ID: <20160420161122.GM3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 05:39:50PM +0800, PC Liao wrote:
> On Wed, 2016-04-20 at 16:29 +0800, Mark Brown wrote:
> > On Wed, Apr 20, 2016 at 02:40:47PM +0800, PC Liao wrote:

> > > +Optional properties:
> > > +- capture-dai: audio codec dai on capture path
> > > +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> > > +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)

> > I sugggested changing this to use a subnode but you've ignored my
> > suggestion...

> Sorry.... It's my mistake.

> You mean that using a subnode.
> This is my example:

>   codec-capture {
> 	  sound-dai = <&rt5650 1>;
>   };

> Does this is your suggestion?

Yeah.  Having refreshed my mind about the APIs a bit the idea is that if
you do things this way then any additional parameters that are needed
for the DAI can be added within the subnode.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160420/f845ba28/attachment.sig>

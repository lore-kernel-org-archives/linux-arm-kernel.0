From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Aug 2013 15:01:06 +0100
Subject: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <520CDAF2.7010101@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk> <520CB2B3.9050804@gmail.com>
 <20130815133925.GA30073@sirena.org.uk> <520CDAF2.7010101@gmail.com>
Message-ID: <20130815140106.GB30073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 03:43:14PM +0200, Daniel Mack wrote:

> And users, in that case, a ssp DAI, just reference a port like so:

>         ssp_dai0: ssp_dai at 0 {
>                 compatible = "mrvl,pxa-ssp-dai";
>                 port = <&ssp0>;
>         };

> Is that something we can live with?

The issue here is that in hardware terms this DAI is just the same thing
as the SSP port that's being referenced so it'd be more natural for the
sound card to just reference the SSP it's using directly rather than
have this DAI sitting in the middle as a proxy.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/0eb8a2af/attachment.sig>

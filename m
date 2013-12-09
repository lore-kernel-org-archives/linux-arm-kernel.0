From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Dec 2013 18:05:41 +0000
Subject: [PATCH] ARM64: dts: Add clock-frequency to model cpu nodes
In-Reply-To: <1386611765.3380.70.camel@linaro1.home>
References: <1386335683-11405-1-git-send-email-broonie@kernel.org>
 <1386611765.3380.70.camel@linaro1.home>
Message-ID: <20131209180541.GQ29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 05:56:05PM +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2013-12-06 at 13:14 +0000, Mark Brown wrote:

> > The clock-frequency property is meaningless for the models but it's a
> > mandatory property so claim that all the cores run at 1MHz.

> Is it a mandatory property? I know we seem to get ugly warnings if it's
> missing but I see no mention of it at all in
> Documentation/devicetree/bindings/arm/cpus.txt (am I looking in the
> wrong place?)

It's mandatory according to ePAPR (see my separate patch copying the
definition into our copy of the binding documents).

> I think this attribute got merged into the kernel with the early power
> related scheduling efforts, but given the state of all that at the
> moment I was guessing it might be obsolete.

No, it's still being used.  At the minute mainline should in theory
balance tasks well enough between the cores when they're all enabled, it
just won't figure out that it's useful to shut one of the clusters down.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/eb3a6602/attachment-0001.sig>

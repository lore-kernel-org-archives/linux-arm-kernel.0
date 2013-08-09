From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 10:19:53 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
In-Reply-To: <5204A716.6070507@gmail.com>
References: <20130808132201.2610aef3@armhf>
 <5204A716.6070507@gmail.com>
Message-ID: <20130809091953.GO6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 10:23:50AM +0200, Sebastian Hesselbarth wrote:
> On 08/08/2013 01:22 PM, Jean-Francois Moine wrote:

> >+i2s1: audio-controller at b4000 {
> >+	compatible = "mrvl,mvebu-audio";
> >+	reg = <0xb4000 0x2210>;
> >+	interrupts = <21>, <22>;
> >+	clocks = <&gate_clk 13>;
> >+	clock-names = "internal";
> >+};

> Also we will need some phandle reference to the audio codec here. As
> this property is ongoing work in ASoC core, I suggest we wait for it
> and propose a binding afterwards.

No, as discussed this should be in the binding for the audio subsystem
not in the binding for an individual component in that subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/93f8f297/attachment.sig>

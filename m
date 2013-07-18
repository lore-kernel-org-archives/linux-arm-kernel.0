From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 22:06:37 +0100
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718173727.2cfa38d3@skate>
References: <20130718134330.5aea00c5@skate>
 <20130718142009.GX24642@n2100.arm.linux.org.uk>
 <20130718173727.2cfa38d3@skate>
Message-ID: <20130718210637.GW22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:37:27PM +0200, Thomas Petazzoni wrote:

> # for i in /sys/kernel/debug/asoc/t5325/dapm/* ; do echo $i ; cat "$i" ; done
> /sys/kernel/debug/asoc/t5325/dapm/Headphone Jack
> Headphone Jack: Off  in 2 out 1
>  in  "static" "HPR"
>  in  "static" "HPL"
> /sys/kernel/debug/asoc/t5325/dapm/Mic Jack
> Mic Jack: Off  in 1 out 0
>  out "static" "MIC2"
>  out "static" "MIC1"
> /sys/kernel/debug/asoc/t5325/dapm/Speaker
> Speaker: Off  in 2 out 1
>  in  "static" "SPKOUTN"
>  in  "static" "SPKOUT"
> /sys/kernel/debug/asoc/t5325/dapm/bias_level
> Off

> I don't see anything that looks unreasonable in there, but I've never
> played with DAPM and related things, so it is very possible that my
> reasonable-guesser might be wrong on this.

All those "Off" things mean that things are powered off which tends not
to involve them making any noise...  Russell mentioned that he thought
this was a lack of DAPM stuff however looking here it seems there are
some DAPM widgets on your board?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/56ddfdb1/attachment.sig>

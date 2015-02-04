From: horms@verge.net.au (Simon Horman)
Date: Wed, 4 Feb 2015 09:28:59 +0900
Subject: [PATCH] ARM: shmobile: silk: initial device tree
In-Reply-To: <CAMuHMdV1U9XV7diKYPwpxAqdzD7tst6e0k=bLgJQ27=YDndn=Q@mail.gmail.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1608366.HtA9yBksdO@wasted.cogentembedded.com>
 <20150202110557.GC7459@leverpostej>
 <54CFE4CE.5090406@cogentembedded.com>
 <20150203003610.GA17629@verge.net.au>
 <CAMuHMdV1U9XV7diKYPwpxAqdzD7tst6e0k=bLgJQ27=YDndn=Q@mail.gmail.com>
Message-ID: <20150204002858.GB29128@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 10:53:01AM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 3, 2015 at 1:36 AM, Simon Horman <horms@verge.net.au> wrote:
> > The only thing that stood out to me about "SILK" was that unlike
> > other renesas boards names in .dtsi files it is all-capitals.
> > Its not a bit deal but as we are on the topic: is that intentional?
> 
> Seems like we can use some consistency:
> 
> $ git grep -w model -- $(git grep -l renesas, -- arch/arm/boot/dts)
> arch/arm/boot/dts/emev2-kzm9d.dts:      model = "EMEV2 KZM9D Board";
> arch/arm/boot/dts/r7s72100-genmai.dts:  model = "Genmai";
> arch/arm/boot/dts/r8a73a4-ape6evm.dts:  model = "APE6EVM";
> arch/arm/boot/dts/r8a7740-armadillo800eva.dts:  model = "armadillo 800 eva";
> arch/arm/boot/dts/r8a7778-bockw-reference.dts:  model = "bockw";
> arch/arm/boot/dts/r8a7778-bockw.dts:    model = "bockw";
> arch/arm/boot/dts/r8a7779-marzen.dts:   model = "marzen";
> arch/arm/boot/dts/r8a7790-lager.dts:    model = "Lager";
> arch/arm/boot/dts/r8a7791-henninger.dts:        model = "Henninger";
> arch/arm/boot/dts/r8a7791-koelsch.dts:  model = "Koelsch";
> arch/arm/boot/dts/r8a7794-alt.dts:      model = "Alt";
> arch/arm/boot/dts/sh73a0-kzm9g.dts:     model = "KZM-A9-GT";
> $
> 
> ePAPR says:
> 
> "The recommended format is: ?manufacturer,model?, where manufacturer is a
>  string describing the name of the manufacturer (such as a stock ticker symbol),
>  and model specifies the model number.
> 
>  Example:
>          model = ?fsl,MPC8349EMITX?;"

Agree we could use some consistency but before we start cooking up names
do we expect this to have any effect on compatibility for users?

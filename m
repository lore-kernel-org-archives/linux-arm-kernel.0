From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 May 2017 08:57:44 +0200
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Set drive-strength
 for ravb pins
In-Reply-To: <CAMuHMdWeLAq7nZ7zu2xJ7vG-oM+-TSZm0eY68Cm-9eUREMjhXg@mail.gmail.com>
References: <1493721024-15042-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWeLAq7nZ7zu2xJ7vG-oM+-TSZm0eY68Cm-9eUREMjhXg@mail.gmail.com>
Message-ID: <20170515065743.GG16545@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 04:39:03PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, May 2, 2017 at 12:30 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > The EthernetAVB should not depend on the bootloader to setup correct
> > drive-strength values.  Values for drive-strength where found by
> > examining the registers after the bootloader has configured the
> > registers and successfully used the EthernetAVB.
> >
> > Based on:
> > * commit 7d73a4da2681 ("arm64: dts: r8a7795: salvator-x: Set drive-strength
> >   for ravb pins")
> > * commit 4903987033be ("arm64: dts: r8a7796: salvator-x: Set drive-strength
> >   for ravb pins")
> >
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > * Compile tested only due to lack of hardware access
> 
> So how did you examine the registers? ;-)

You got me there: copy-paste gone wrong.

> Hence I examined the registers myself:
>   - H3ULCB has the same register settings as Salvator-X with H3 ES1.0
>   - M3ULCB has the same register settings as Salvator-X with M3-W ES1.0
>     or H3 ES2.0.

That was my assumption, which is what I should have written.
But as you have checked - thanks for that - I will leave the changelog
as-is and queue up the patch.

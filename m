From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 Feb 2018 07:51:50 +0100
Subject: [PATCH 3/4] dt-bindings: arm: Document Renesas R-Car M3-N-based
 Salvator-X board
In-Reply-To: <CAMuHMdXkpEoKxT-z0FunnfdjUpUZZP8GvbC5wAuj-qseQCVkzQ@mail.gmail.com>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
 <1519668225-12548-4-git-send-email-geert+renesas@glider.be>
 <20180227082238.e2kk6s4wogwwltvb@verge.net.au>
 <CAMuHMdXkpEoKxT-z0FunnfdjUpUZZP8GvbC5wAuj-qseQCVkzQ@mail.gmail.com>
Message-ID: <20180228065150.zmutu3svbsztfilx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 10:25:42PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Feb 27, 2018 at 9:22 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Feb 26, 2018 at 07:03:44PM +0100, Geert Uytterhoeven wrote:
> >> The Renesas Salvator-X development board can be equipped with an R-Car
> >> H3, M3-W, or M3-N SiP, which are pin-compatible.
> >>
> >> Document board part number and compatible values for the version with
> >> R-Car M3-N.
> >>
> >> The board part number was extracted from a big patch by Takeshi Kihara
> >> in the BSP.
> 
> >> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> >> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> >> @@ -108,6 +108,8 @@ Boards:
> >>      compatible = "renesas,salvator-x", "renesas,r8a7795"
> >>    - Salvator-X (RTP0RC7796SIPB0011S)
> >
> > Here we have: Name (Part No)
> 
> That's the standard (highest number of occurrences) way.
> 
> >>      compatible = "renesas,salvator-x", "renesas,r8a7796"
> >> +  - Salvator-X (RTP0RC7796SIPB0011S (M3N))
> >
> > Here we have: Name (Part No (SoC))
> 
> This one is special: it's basically an M3-N prototype board made by taking
> a Salvator-X/M3-W board, and replacing the M3-W SiP by an M3-N SiP.
> Hence the board part number is the same.
> 
> >> +    compatible = "renesas,salvator-x", "renesas,r8a77965"
> >>    - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
> >
> > And here we have: Name (Version, Part No)
> 
> AFAIU, "Salvator-XS" really means "Salvator-X 2nd version".
> So it's not "Version", but "Alternative Board Name".
> There's a similar thing with the ULCB boards:
> 
>   - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
>     H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
>   - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
> 
> >>      compatible = "renesas,salvator-xs", "renesas,r8a7795"
> >>    - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
> >
> > Can we think about making this more consistent?
> 
> I'm afraid not. Naming seems to become only more complex over time...
> Unless you have great hands and great ideas ;-)

Not so many good ideas this morning.

I've applied this as is. We can revisit if the need arises.

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 09:52:55 +0200
Subject: [PATCH v3 2/3] dt-bindings: input: Add R_LRADC support for A83T
In-Reply-To: <CAAST=9wKRA=EiU6U85N7k9mtnbkfDwa-N5DyfkF88zYk5-EDiQ@mail.gmail.com>
References: <20170624024515.4669-1-techping.chan@gmail.com>
 <20170624024515.4669-3-techping.chan@gmail.com>
 <20170626171524.cqfyasetpsfr6xfg@flea.lan>
 <CAAST=9x+fS41tznuJ9hQ-cQxecKN751=61YkhEt31DvpeqeEcA@mail.gmail.com>
 <20170627173159.g3t3rbts3y7z6jf7@flea>
 <CAAST=9wKRA=EiU6U85N7k9mtnbkfDwa-N5DyfkF88zYk5-EDiQ@mail.gmail.com>
Message-ID: <20170629075255.7vvzhiaqll457em4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 29, 2017 at 12:35:30PM +0800, Ziping Chen wrote:
> 2017-06-28 1:31 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> > On Tue, Jun 27, 2017 at 11:18:17PM +0800, Ziping Chen wrote:
> >> 2017-06-27 1:15 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> >> > Hi,
> >> >
> >> > On Sat, Jun 24, 2017 at 10:45:14AM +0800, Ziping Chen wrote:
> >> >> From: Ziping Chen <techping.chan@gmail.com>
> >> >>
> >> >> Allwinner A83T SoC has a low res adc like the one
> >> >> in Allwinner A10 SoC.
> >> >>
> >> >> Add binding for it.
> >> >>
> >> >> Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> >> >> Acked-by: Rob Herring <robh@kernel.org>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 6 ++++--
> >> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> >> >> index 4357e498ef04..525d85e3043f 100644
> >> >> --- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> >> >> +++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> >> >> @@ -2,12 +2,14 @@ Allwinner sun4i low res adc attached tablet keys
> >> >>  ------------------------------------------------
> >> >>
> >> >>  Required properties:
> >> >> - - compatible: "allwinner,sun4i-a10-lradc-keys"
> >> >> + - compatible: should be one of the following string:
> >> >> +             "allwinner,sun4i-a10-lradc-keys"
> >> >> +             "allwinner,sun8i-a83t-r-lradc-keys"
> >> >
> >> > This doesn't really have anything related to keys, and can be used
> >> > purely as an ADC.
> >> >
> >> > I know this is the compatible that was used for the A10, but I'd
> >> > rather drop the keys for the the new compatible.
> >> >
> >>
> >> LRADC is named KEYADC in some other SoCs' User Manual(such as R40 User
> >> Manual V1.0), thus LRADC is related to keys.
> >
> > It's still called LRADC on the A83T, so we'll use that name. If we
> > ever need another compatible for the R40, then yes, keyadc would make
> > sense in that case.
> 
> Hi,
> 
> So... whether to use "sun4i-lradc" to replace "sun4i-lradc-keys"?
> 
> I think it should be separated, one is the input subsystem, the other
> is the iio subsystem.

I was just talking about your compatible here, and was basically
suggesting to do sed 's/sun8i-a83t-r-lradc-keys/sun8i-a83t-r-lradc/',
that's all.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/e3d33653/attachment.sig>

From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 15 Jan 2016 07:34:31 +0100
Subject: [PATCH 14/14] ARM: dts: imx6: make audmux optional for i.MX6UL
 sound driver
In-Reply-To: <20160115023809.GA3284@rob-hp-laptop>
References: <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-11-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-12-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-13-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-14-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-15-git-send-email-LW@KARO-electronics.de>
 <20160115023809.GA3284@rob-hp-laptop>
Message-ID: <20160115073431.5b31c81c@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Tue, Jan 12, 2016 at 06:21:31PM +0100, Lothar Wa?mann wrote:
> > i.MX6UL does not have the audio multiplexer (AUDMUX) like the other
> > i.MX6 SoCs, but apart from that can use the same audio driver. Make
> > audmux optional for the imx-sgtl5000 driver, so it can be used on
> > i.MX6UL too. Furthermore i.MX6UL requires use of the SAI interface
> > rather than SSI. Change the DTS documentation accordingly.
> > 
> > The patch with the corresponding changes to the imx-sgtl5000 driver
> > will be sent separately.
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  .../bindings/sound/imx-audio-sgtl5000.txt          | 26 +++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> > index 2f89db8..fd46671 100644
> > --- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> > +++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> > @@ -6,7 +6,7 @@ Required properties:
> >  
> >    - model		: The user-visible name of this sound complex
> >  
> > -  - ssi-controller	: The phandle of the i.MX SSI controller
> > +  - ssi-controller	: The phandle of the i.MX SSI (or SAI) controller
> >  
> >    - audio-codec		: The phandle of the SGTL5000 audio codec
> >  
> > @@ -39,6 +39,16 @@ Required properties:
> >  Note: The AUDMUX port numbering should start at 1, which is consistent with
> >  hardware manual.
> >  
> > +Optional properties:
> > +  - fsl,no-audmux	: boolean
> > +    			  Required for i.MX6UL (and maybe other SoCs)
> > +    			  which don't have an AUDMUX, but still
> > +			  feature the same audio subsystem otherwise.
> 
> It would have been better if this was a phandle to the audmux and lack 
> of the property meant no audmux. Too late for that I guess.
> 
That would mean, that all existing dtbs would have to be changed, and
older DTBs with newer kernels wouldn't work.

But this patch is obsolete anyway. The simple-card driver can be used
instead of the imx-audio-sgtl5000 as Mark Brown suggested in
<20160112182253.GD6588@sirena.org.uk>. I'll post an updated patch series soon.


Lothar Wa?mann

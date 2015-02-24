From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 24 Feb 2015 07:42:33 +0100
Subject: Ask for help. ARM:mvebu (CM-A510), add sound support using
 TLV320AIC23 audio-codec
In-Reply-To: <54EB8D34.7040003@gmail.com>
References: <54EB8D34.7040003@gmail.com>
Message-ID: <CAPv3WKdbe074TRfrLO11r6Pf6-sd7a9PXZUBVSrJ14TDHK=wBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

I think that the lack of space in all three input routings can make a
difference. Please let know if adding it helps.

Best regards,
Marcin

2015-02-23 21:27 GMT+01:00 Gabriel Dobato <dobatog@gmail.com>:
> Hello,
>
> I am trying to set the sound system using "simple-audio-card" and
> TLV320AIC23B audio codec in  Compulab CM-510 SoM.
>
> This is my structure in DT, according to
> ./KERNEL/Documentation/devicetree/bindings/sound/simple-card.txt,
> /KERNEL/Documentation/devicetree/bindings/sound/widgets.txt and the source
> code of the audio-codec ./KERNEL/sound/soc/codecs/tlv320aic23.c :
>
>  sound {
>                 compatible = "simple-audio-card";
>                 simple-audio-card,name = "OnboardTLV320AIC23B";
>                 simple-audio-card,format = "i2s";
>                 simple-audio-card,bitclock-master = <&dailink_master>;
>                 simple-audio-card,frame-master = <&dailink_master>;
>                 simple-audio-card,widgets =
>                         "Microphone", "Mic Input",
>                         "Line", "Line Input",
>                         "Line", "Line Out",
>                         "Speaker", "Speaker",
>                         "Headphone", "Headphone Jack";
>
>                 simple-audio-card,routing =
>                         "Line Out", "LOUT",
>                         "Line Out", "ROUT",
>                         "Line Out", "RHPOUT",
>                         "Line Out", "LHPOUT",
>                         "LLINEIN","Line Input",
>                         "RLINEIN","Line Input",
>                          "MICIN","Mic Input";
>                 simple-audio-card,cpu {
>                                 sound-dai = <&audio0 0>;
>                         };
>                 dailink_master: simple-audio-card,codec {
>                                 sound-dai = <&opt_audio>;
>                         };
>                 };
> };
>
>
> /* TLV320AIC23 */
> &opt_audio {
>             status = "okay";
>             #sound-dai-cells= <0>;
>  };
>
>
> And this is the kernel trace:
>
> ...
> tlv320aic23-codec 0-001a: Control not supported for path LLINEIN -> [NULL]
> -> Line Input
> tlv320aic23-codec 0-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line
> Input
> tlv320aic23-codec 0-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line
> Input
> tlv320aic23-codec 0-001a: Control not supported for path RLINEIN -> [NULL]
> -> Line Input
> tlv320aic23-codec 0-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line
> Input
> tlv320aic23-codec 0-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line
> Input
> tlv320aic23-codec 0-001a: Control not supported for path MICIN -> [NULL] ->
> Mic Input
> tlv320aic23-codec 0-001a: ASoC: no dapm match for MICIN --> NULL --> Mic
> Input
> tlv320aic23-codec 0-001a: ASoC: Failed to add route MICIN -> NULL -> Mic
> Input
> usb 2-1.2: new high-speed USB device number 3 using orion-ehci
> asoc-simple-card sound: tlv320aic23-hifi <-> i2s mapping ok
> ...
>
> ALSA device list:
>   #0: OnboardTLV320AIC23B
> ...
>
> [....] Setting up ALSA...amixer: Invalid command!
> ...
>
>
> I think I have written the node according to the documentation, but probably
> I miss something.
> Anyone has faced a similar problem?
>
>
> I would really appreciate some kind of help.
>
> Thank you,
>
> Gabriel
>
>
>
>
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

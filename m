From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Thu, 21 Nov 2013 02:58:22 +0000
Subject: [PATCHv2 3/8] ARM: dts: Enables SAI ALSA SoC DAI device for
 Vybrid VF610 TOWER board.
In-Reply-To: <87hab7hxfx.fsf@nbsps.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com>
 <87bo1hk2i7.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828AD451@039-SN2MPN1-012.039d.mgd.msft.net>
 <87hab7hxfx.fsf@nbsps.com>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828B5046@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>> This patch add and enable SAI device.
> >>>
> >>> arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
> >>> 1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/vf610-twr.dts
> >>> b/arch/arm/boot/dts/vf610-twr.dts index 1a58678..e4106dd 100644
> >>> --- a/arch/arm/boot/dts/vf610-twr.dts
> >>> +++ b/arch/arm/boot/dts/vf610-twr.dts
> >>>>> -57,6 +57,12 @@
> >>> 	status = "okay";
> >>> };
> >>
> >> Should we put a comment here that a TWR-AUDIO-SGTL board is needed?
> >> Or is this better in a menuconfig?  I guess TWR-AUDIO-SGTL is needed
> >> as this codec is not on the VF610-TWR main board?
> >>
> >
> > Yes, the SGTL5000 codec is not on the VF610-TWR main board, and needs
> an extra
> > 	TWR-AUDIO-SGTL board.
> >
> > IMO, puting this comment in the menuconfig is much better.
> 
> I agree.  I guess the patch set 6 makes more sense.  Also, you might
> consider adding a printk in the 'fsl_sgtl5000_probe()'.  I guess that
> devm_snd_soc_register_card() will fail if the board is not present?  
>

Yes, you are right.
The logs:
+++++++++++
vf610-sgtl5000 sound.3: ASoC: CODEC (null) not registered
vf610-sgtl5000 sound.3: register soc sound card failed :-517
-----------


> +	ret = devm_snd_soc_register_card(&pdev->dev, &fsl_sgt1500_card);
> +	if (ret) {
> +		dev_err(&pdev->dev, "register soc sound card failed :%d\n"
> +                               "TWR-AUDIO-SGTL board required.\n",
> +				ret);
> +		return ret;
> +	}
> 
> Especially, you can make one kernel that handles both cases w/wo TWR-
> AUDIO-SGTL board attached.
> 

Yes, it looks nicer.

Well, as one log about the CODEC already exists? Should the "TWR-AUDIO-SGTL board required.\n" log is still needed here ?


--
Best Regards,
Xiubo

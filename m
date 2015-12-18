From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Dec 2015 21:53:41 +0100
Subject: [linux-sunxi] Re: [PATCH v2 2/4] ASoC: sun4i-codec: Add support
 for PA gpio pin
In-Reply-To: <566EE953.3050702@redhat.com>
References: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
 <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
 <20151214155616.GL19456@lukather> <566EE953.3050702@redhat.com>
Message-ID: <20151218205341.GO30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 05:07:47PM +0100, Hans de Goede wrote:
> >>+static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
> >>+				 struct snd_kcontrol *k, int event)
> >>+{
> >>+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
> >>+
> >>+	if (scodec->gpio_pa)
> >>+		gpiod_set_value_cansleep(scodec->gpio_pa,
> >>+					 !!SND_SOC_DAPM_EVENT_ON(event));
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static const struct snd_soc_dapm_widget sun4i_codec_card_dapm_widgets[] = {
> >>+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
> >>+};
> >>+
> >>+static const struct snd_soc_dapm_route sun4i_codec_card_dapm_routes[] = {
> >>+	{ "Speaker", NULL, "Power Amplifier" },
> >>+};
> >
> >Shouldn't it be tied to the HP outputs instead?
> 
> You're right, the HP outputs are the final outputs, and since this is
> for enabling an external amplifier you're right. Since Mark has already
> merged this patch I will do a follow up patch to fix this.

Great, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/21c3a892/attachment.sig>

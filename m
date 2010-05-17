From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 18 May 2010 05:53:12 +0800
Subject: [PATCH] NUC900/audio: add nuc900 audio driver support
In-Reply-To: <20100517134622.GA5257@opensource.wolfsonmicro.com>
References: <4BF01069.6060102@gmail.com>
	<20100517024425.GA2485@opensource.wolfsonmicro.com>
	<4BF0E184.204@gmail.com>
	<20100517134622.GA5257@opensource.wolfsonmicro.com>
Message-ID: <AANLkTilE8u9MDmcJja4yJhUgAGiEOS-FYZeqHx-KUzKp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks! I will submit it again.
2010/5/17, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, May 17, 2010 at 02:26:12PM +0800, Wan ZongShun wrote:
>> >On Sun, May 16, 2010 at 11:34:01PM +0800, Wan ZongShun wrote:
>
>> >>+	if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
>> >>+		dev_err(nuc900_audio->dev, "AC97 codec cold reset failed!\n");
>
>> >What is this actually checking in the hardware?  Not all CODECs enable
>> >the AC97 link by default after a cold reset, the standard allows them to
>> >power up in a low power state which will
>
>> The bit 'CODEC_READY' indicates the external AC97 audio CODEC is ready,
>> I just forget to implement the warm reset operation, if need, I will do
>> it. In addition, Can I add the checking CODEC_READY operation to
>> warm reset function?
>
> That sounds fine.  For defensiveness it might be worth checking the
> CODEC on register reads and writes too (it'd make diagnostics a bit
> easier).
>
>> >>+#define	IIS_EN			0x0002
>
>> >Looks like there's I2S support to come?
>
>> Yes,nuc900 supports both IIS and AC97,but my board only enable AC97
>> support,
>> what's up here?
>
> Nothing, just curious.
>


-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com

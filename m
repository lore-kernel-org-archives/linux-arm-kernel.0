From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 1 Sep 2011 12:33:10 +0900
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs based
	on platform device name.
In-Reply-To: <001d01cc684e$9c49ecd0$d4ddc670$%kim@samsung.com>
References: <1731819.jJi37IsjvJ@flatron> <4002702.FticUbImag@flatron>
	<20110831124432.GF14976@sirena.org.uk>
	<CA+Ln22Gak4engAmccbodi2PbYH1PwQ1KuACd9thX_8W5Cr544Q@mail.gmail.com>
	<001d01cc684e$9c49ecd0$d4ddc670$%kim@samsung.com>
Message-ID: <CAH9JG2UiuaCyOk24hC=240ptQa8CKCVkXHaQzNt=YcnyQksnOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2011 at 11:26 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Tomasz Figa wrote:
>>
>> 2011/8/31 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>> > On Wed, Aug 31, 2011 at 02:34:15PM +0200, Tomasz Figa wrote:
>> >
>> >> This patch is a prerequisite to adding generic time support for
> S3C64xx.
>> >> It makes possible to differentiate SoCs, required to exclude timers 3
> and 4
>> >> from PWM driver only on S3C64xx.
>> >
>> > Now we have the cpu_is_foo() support for Samsung CPUs can we use that
>> > instead?
>> >
>>
>> Well, I thought about it, but I based my patches on latest stable sources
> and
>> cpu_is_s3c64xx wasn't there yet. Should I rebase them to Linus' tree?
>>
>> I'm not yet fully used to submitting patches here, so things like choosing
> the
>> base for patches are sometimes a bit confusing to me and I couldn't find
> any
>> guide. Should fixes be based on stable tree and new features implemented
> on
>> top of current Linus' tree? Could you give me some advice on this?
>
> Hi Tomasz,
>
> You can use "soc_is_s3c64xx()" based on Samsung -next tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-next

+static struct platform_device_id s3c_pwm_driver_ids[] = {
+       {
+               .name           = "s3c24xx-pwm",
+               .driver_data    = TYPE_GENERIC,
+       }, {
+               .name           = "s3c64xx-pwm",
+               .driver_data    = TYPE_S3C64XX,
+       },
+};
+MODULE_DEVICE_TABLE(platform, s3c_pwm_driver_ids);

doesn't it right way?
do you want to use the soc_is_* at device?

>
> In addition, would be better to me if you could work about Samsung stuff
> based on it.
>
> As a note, your previous patches are in there :)
>
> If any problems, please let me know...
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

From: jbe@pengutronix.de (=?iso-8859-15?q?J=FCrgen_Beisert?=)
Date: Wed, 25 Sep 2013 11:40:36 +0200
Subject: ARM/Samsung/S3C24xx: Linux-3.11 crashes when using PWM
In-Reply-To: <5242AA7C.4010905@samsung.com>
References: <201309251029.44265.jbe@pengutronix.de>
 <5242AA7C.4010905@samsung.com>
Message-ID: <201309251140.36582.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Wednesday 25 September 2013 11:18:52 Sylwester Nawrocki wrote:
> On 25/09/13 10:29, J?rgen Beisert wrote:
> > Change one single line:
> >
> > diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c
> > b/arch/arm/mach-s3c24xx/mach-mini2440.c index a83db46..d8273da 100644
> > --- a/arch/arm/mach-s3c24xx/mach-mini2440.c
> > +++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
> > @@ -519,6 +519,7 @@ static struct platform_device *mini2440_devices[]
> > __initdata = { &s3c_device_iis,
> >         &uda1340_codec,
> >         &mini2440_audio,
> > +       &s3c_device_timer[0],
> >  };
>
> I think you need to add instead:
>
> 	&samsung_device_pwm,
>
> IIRC I had this working, can't verify at the moment as I don't
> have access to the board right now. Please see commit:
>
> 7fa33bdb4c44155e390c9ebbc5aa4c5cfc73f6fa
> ARM: SAMSUNG: Modify board files to use new PWM platform device

Seems valid for 3.12, but not for 3.11.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Jul 2013 13:20:17 +0200
Subject: [PATCH 2/5] iio: at91: Use different prescal, startup mask in MR
 for different IP
In-Reply-To: <51E50864.6020904@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-3-git-send-email-josh.wu@atmel.com>
 <20130715125815.GC2962@lukather> <51E505EA.4060502@atmel.com>
 <51E50864.6020904@atmel.com>
Message-ID: <20130716112017.GC3125@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 10:46:28AM +0200, Nicolas Ferre wrote:
> >>capabilities from which compatible is declared.
> >>
> >>It seems safer.
> 
> I see it as handier in the sense that a different IP version can be
> compatible with an older IP version: so we do not need to modify the
> driver just to use another SoC.
> 
> On your side Maxime, what makes you say that it is "safer"?

Well, the register holding the IP version seem to be not programmed in
some cases (or, at least, the driver handles this case).

So, what would happen if one SoC was in such case? You wouldn't be able
to use the ADC/touchscreen, even though the IP in itself might very well
work, which doesn't sound very nice, while the DT will always be there,
and will always have a compatible property.

> >Ok, that make sense. I will use compatible names for the capabilities in
> >next version. Thanks.
> 
> Hold on a little bit Josh, I know that Jean-Christophe is not in
> favor of the use of multiple compatible strings. So, as the code is
> already there, let's wait and see if we find another argument...

And you know my feeling about this for quite some time already ;)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/17f0b0cb/attachment-0001.sig>

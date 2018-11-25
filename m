From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 25 Nov 2018 10:39:53 +0000
Subject: [PATCH] iio: adc: meson-saradc: check for devm_kasprintf failure
In-Reply-To: <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
References: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
 <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
Message-ID: <20181125103953.6d7bcf76@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2018 22:44:55 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Thu, Nov 22, 2018 at 8:52 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > devm_kasprintf() may return NULL on failure of internal allocation thus
> > the assignments to  init.name  are not safe if not checked. On error
> > meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
> > (unlikely) failure case of devm_kasprintf() should be fine here.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")  
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> thank you for the patch!
> I tested the non-error case on my Odroid-C1 and it still works fine.
Applied.  I also added a tested by tag for you Martin as it's always nice
for the log to reflect when people make the effort!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> 
> Regards
> Martin

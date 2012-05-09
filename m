From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 9 May 2012 13:33:54 +0530
Subject: [PATCH 07/10] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
In-Reply-To: <1336514694-22393-8-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-8-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CABb+yY0Yu3Em+oU5+xjzBpxLaTrZ34Gxh4TK0-ra_z23RNBdJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 3:34 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
>
> The set_level callback in the controller data, which is used to configure
> the slave select line, cannot be supported when migrating the driver to
> device tree based discovery. Since all the platforms currently use gpio
> as the slave select line, this callback can be removed from the
> controller data and replaced with call to gpio_set_value in the driver.
>
This patch is ok.
Separately, you might also want to see if we really need the air-tight
protection of spin_lock_irqsave around enable_cs - IIRC someone
had a CS coming out of an gpio extender connected over I2C

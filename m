From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 10 Jul 2012 22:22:31 +0530
Subject: [PATCH v4 5/6] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
In-Reply-To: <20120710143844.GB11698@sirena.org.uk>
References: <1341930459-25223-1-git-send-email-thomas.abraham@linaro.org>
 <1341930459-25223-6-git-send-email-thomas.abraham@linaro.org>
 <20120710143844.GB11698@sirena.org.uk>
Message-ID: <CAJuYYwQ4wio0CxPAVaNBoD7=vMgUS0CCZB45aSst-DW2zOTn1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2012 20:08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 10, 2012 at 07:57:38PM +0530, Thomas Abraham wrote:
>> The set_level callback in the controller data, which is used to configure
>> the slave select line, cannot be supported when migrating the driver to
>> device tree based discovery. Since all the platforms currently use gpio
>> as the slave select line, this callback can be removed from the
>> controller data and replaced with call to gpio_set_value in the driver.
>
> This is currently buggy, BTW, as the driver never requests the GPIO.

In non-dt case, the platform code supplying the gpio number (slave
select line) is responsible for requesting the gpio during the
machine_init call. So the gpio request is not called in the driver for
that gpio. In dt case, the 6th patch adds dt support and that patch
includes a gpio request call. Hence, this looks okay to me. Please
suggest if you still feel that there are changes required.

Thanks for reviewing the patches.

Regards,
Thomas.

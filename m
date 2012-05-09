From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 9 May 2012 11:10:14 +0200
Subject: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <20120509085617.GB28702@sirena.org.uk>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
Message-ID: <201205091110.15224.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 9. Mai 2012, 10:56:17 schrieb Mark Brown:
> On Wed, May 09, 2012 at 03:34:50AM +0530, Thomas Abraham wrote:
> > +	s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);
> 
> Shouldn't we just set the name in the struct platform_device rather than
> requiring the machine to pass it through by hand?

Similar to the adc and rtc driver, all Samsung platforms reuse a common 
platform-device definition for the s3c64xx-spi and simply will set the correct 
name when the machine type is determined during boot.

I.e. I will also have to change my out-of-tree machine stuff to set the 
s3c2443-spi name using this method.

The alternative is creating a mulitude of platform devices for each possible 
machine type using this driver.


Heiko

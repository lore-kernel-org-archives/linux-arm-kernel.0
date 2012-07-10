From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jul 2012 17:57:17 +0100
Subject: [PATCH v4 5/6] spi: s3c64xx: Remove the 'set_level' callback
 from controller data
In-Reply-To: <CAJuYYwQ4wio0CxPAVaNBoD7=vMgUS0CCZB45aSst-DW2zOTn1w@mail.gmail.com>
References: <1341930459-25223-1-git-send-email-thomas.abraham@linaro.org>
 <1341930459-25223-6-git-send-email-thomas.abraham@linaro.org>
 <20120710143844.GB11698@sirena.org.uk>
 <CAJuYYwQ4wio0CxPAVaNBoD7=vMgUS0CCZB45aSst-DW2zOTn1w@mail.gmail.com>
Message-ID: <20120710165716.GJ10022@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 10:22:31PM +0530, Thomas Abraham wrote:

> In non-dt case, the platform code supplying the gpio number (slave
> select line) is responsible for requesting the gpio during the
> machine_init call. So the gpio request is not called in the driver for
> that gpio. In dt case, the 6th patch adds dt support and that patch
> includes a gpio request call. Hence, this looks okay to me. Please
> suggest if you still feel that there are changes required.

That's not really particularly sensible given that the changes remove
the option to use anything except GPIOs, the GPIO request should be done
unconditionally in the driver now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/48c3e3ee/attachment.sig>

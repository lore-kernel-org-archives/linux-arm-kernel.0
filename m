From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 10 Jul 2012 22:56:26 +0530
Subject: [PATCH v4 5/6] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
In-Reply-To: <20120710165716.GJ10022@opensource.wolfsonmicro.com>
References: <1341930459-25223-1-git-send-email-thomas.abraham@linaro.org>
 <1341930459-25223-6-git-send-email-thomas.abraham@linaro.org>
 <20120710143844.GB11698@sirena.org.uk>
 <CAJuYYwQ4wio0CxPAVaNBoD7=vMgUS0CCZB45aSst-DW2zOTn1w@mail.gmail.com>
 <20120710165716.GJ10022@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwSi-1nBM40SWt359W0Lr2n_yVX5tvWfOS77bmLQRt_9fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2012 22:27, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 10, 2012 at 10:22:31PM +0530, Thomas Abraham wrote:
>
>> In non-dt case, the platform code supplying the gpio number (slave
>> select line) is responsible for requesting the gpio during the
>> machine_init call. So the gpio request is not called in the driver for
>> that gpio. In dt case, the 6th patch adds dt support and that patch
>> includes a gpio request call. Hence, this looks okay to me. Please
>> suggest if you still feel that there are changes required.
>
> That's not really particularly sensible given that the changes remove
> the option to use anything except GPIOs, the GPIO request should be done
> unconditionally in the driver now.

Yes, that is right. I will add the gpio request in the driver and
resubmit the patch. Thanks.

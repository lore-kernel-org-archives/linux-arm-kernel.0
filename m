From: denis@eukrea.com (Denis Carikli)
Date: Tue, 24 Jun 2014 12:38:43 +0200
Subject: [PATCH v2 3/6] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <53A55EDF.4010104@kernel.org>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
 <1402672899-6995-4-git-send-email-denis@eukrea.com>
 <53A55EDF.4010104@kernel.org>
Message-ID: <53A95533.8090500@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2014 12:30 PM, Jonathan Cameron wrote:
>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),    \
> No known info on converting this to real voltages?  I'd normally expect
> a scale parameter at least with any raw channel output, but fair enough
> if it's not obvous what this should be.

We know the internal reference voltage.
We can also know the external reference voltage by representing it as a 
regulator.

Since there are many combinations should a regulator for each 
reference(external reference, xp, yp, xn and yn) be used?

Denis.

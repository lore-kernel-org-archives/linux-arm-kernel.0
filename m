From: denis@eukrea.com (Denis Carikli)
Date: Mon, 23 Jun 2014 18:43:14 +0200
Subject: [PATCH v3 3/6] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <53A563B0.60708@kernel.org>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com>
 <1402910933-20534-3-git-send-email-denis@eukrea.com>
 <53A563B0.60708@kernel.org>
Message-ID: <53A85922.1000209@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2014 12:51 PM, Jonathan Cameron wrote:
>> +static irqreturn_t mx25_gcq_irq(int irq, void *data)
>> +{
>> +    struct mx25_gcq_priv *priv = data;
>> +    u32 stats;
> Not that much in here, but perhaps still makes sense for this to be a
> threaded
> irq?
What would be the advantage of converting it to be a threaded IRQ?

I guess that there will be no use of IRQF_SHARED and that only this 
driver will have to handle the GCQ IRQ in the future.

Denis.

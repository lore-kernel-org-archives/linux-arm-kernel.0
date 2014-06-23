From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 23 Jun 2014 19:13:14 +0100
Subject: [PATCH v3 3/6] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <53A85922.1000209@eukrea.com>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com>
 <1402910933-20534-3-git-send-email-denis@eukrea.com>
 <53A563B0.60708@kernel.org> <53A85922.1000209@eukrea.com>
Message-ID: <53A86E3A.6000400@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/14 17:43, Denis Carikli wrote:
> On 06/21/2014 12:51 PM, Jonathan Cameron wrote:
>>> +static irqreturn_t mx25_gcq_irq(int irq, void *data)
>>> +{
>>> +    struct mx25_gcq_priv *priv = data;
>>> +    u32 stats;
>> Not that much in here, but perhaps still makes sense for this to be a
>> threaded
>> irq?
> What would be the advantage of converting it to be a threaded IRQ?
>
> I guess that there will be no use of IRQF_SHARED and that only this driver will have to handle the GCQ IRQ in the future.
>
Fair enough.  Was more of an idle thought that anything else!

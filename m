From: jic23@kernel.org (Jonathan Cameron)
Date: Fri, 29 Mar 2013 09:30:06 +0000
Subject: [PATCH v2] iio: mxs-lradc: Do hardware initialization earlier
In-Reply-To: <201303282358.08630.marex@denx.de>
References: <1364508273-14955-1-git-send-email-alexandre.belloni@free-electrons.com>
 <201303282358.08630.marex@denx.de>
Message-ID: <51555F1E.2070407@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 10:58 PM, Marek Vasut wrote:
> Dear Alexandre Belloni,
> 
>> We need to initialize hardware before registering the touchscreen. Else,
>> we end up setting registers in mxs_lradc_ts_open(), getting called just
>> after registering the touchscreen with input_register_device() and by
>> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
>> correct configuration.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
> 
> Acked-by: Marek Vasut <marex@denx.de>
Applied to togreg branch of iio.git. Thanks.
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

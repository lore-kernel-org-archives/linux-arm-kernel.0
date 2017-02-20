From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Mon, 20 Feb 2017 21:25:58 +0100
Subject: [PATCH] iio: adc: xilinx: Fix error handling
In-Reply-To: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
References: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
Message-ID: <63f3a01d-4b78-f069-5aa1-c7f703b4e78e@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/02/2017 ? 09:35, Lars-Peter Clausen a ?crit :
> On 02/19/2017 09:29 PM, Christophe JAILLET wrote:
>> Reorder error handling labels in order to match the way resources have
>> been allocated.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
> Thanks, looks good.
>
> Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
>
> I think there is one more issue
>
>      ret = xadc->ops->setup(pdev, indio_dev, irq);
>      if (ret)
>          goto err_free_samplerate_trigger;
>
> should be
>
> 	goto err_clk_disable_unprepare;
>
I agree.

Would you like me to send a V2 with both fixes or a sepparate patch?

CJ

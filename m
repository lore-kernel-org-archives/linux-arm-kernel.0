From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 May 2013 22:02:00 +0400
Subject: [PATCH 1/1] mmc: of_mmc_spi: fix card detect irq
In-Reply-To: <20130527141306.GS24476@game.jcrosoft.org>
References: <1369571337-9300-1-git-send-email-plagnioj@jcrosoft.com>
 <51A25ECA.2060001@cogentembedded.com>
 <20130527141306.GS24476@game.jcrosoft.org>
Message-ID: <51A39F98.4010904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-05-2013 18:13, Jean-Christophe PLAGNIOL-VILLARD wrote:

>>> set missing irq type the IRQF_ONESHOT

>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: stable <stable@vger.kernel.org> # 3.4+
>>> Cc: linux-mmc at vger.kernel.org
>>> ---
>>>   drivers/mmc/host/of_mmc_spi.c |    4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)

>>> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
>>> index d720b5e..cfb2e61 100644
>>> --- a/drivers/mmc/host/of_mmc_spi.c
>>> +++ b/drivers/mmc/host/of_mmc_spi.c
>>> @@ -74,8 +74,8 @@ static int of_mmc_spi_init(struct device *dev,
>>>   {
>>>   	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
>>> -	return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
>>> -				    dev_name(dev), mmc);
>>> +	return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
>>> +		IRQF_ONESHOT, dev_name(dev), mmc);

>>      Please don't change the indentation.

> too long > 80

     Reflow it then into several lines.

> Best Regards,
> J.

WBR, Sergei

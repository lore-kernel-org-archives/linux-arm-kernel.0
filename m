From: b32955@freescale.com (Huang Shijie)
Date: Fri, 7 Sep 2012 10:48:36 +0800
Subject: [PATCH 2/2] serial: mxs-auart: put the device in mxs_auart_probe()
In-Reply-To: <20120907024349.GH26709@S2101-09.ap.freescale.net>
References: <1346985521-2248-1-git-send-email-shijie8@gmail.com>
 <1346985521-2248-2-git-send-email-shijie8@gmail.com>
 <20120907024349.GH26709@S2101-09.ap.freescale.net>
Message-ID: <50496084.3090400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?09?07? 10:43, Shawn Guo ??:
> On Thu, Sep 06, 2012 at 10:38:41PM -0400, Huang Shijie wrote:
>> We call the get_device() in the mxs_auart_probe().
>> For the balance of the reference count, we should put the
>> device in the mxs_auart_remove().
>>
>> Signed-off-by: Huang Shijie<shijie8@gmail.com>
>> ---
>>   drivers/tty/serial/mxs-auart.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
>> index ea5f888..6898413 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -796,6 +796,7 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
>>
>>   	auart_port[pdev->id] = NULL;
>>
>> +	put_device(s->dev);
>>   	clk_put(s->clk);
>>   	free_irq(s->irq, s);
>>   	kfree(s);
> So the error path of probe needs function fixing too, right?
>
OK.

Send out the new version right now.


Huang Shijie

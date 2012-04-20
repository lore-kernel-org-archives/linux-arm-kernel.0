From: stigge@antcom.de (Roland Stigge)
Date: Fri, 20 Apr 2012 15:14:46 +0200
Subject: [PATCH v5] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <20120420120950.GA15613@pengutronix.de>
References: <1334913755-10466-1-git-send-email-stigge@antcom.de>
 <20120420120950.GA15613@pengutronix.de>
Message-ID: <4F916146.1080904@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/20/2012 02:09 PM, Wolfram Sang wrote:
>> Signed-off-by: Roland Stigge <stigge@antcom.de> Reviewed-by: Arnd
>> Bergmann <arnd@arndb.de> Acked-by: Wolfram Sang
>> <w.sang@pengutronix.de>
> 
> NACK! I said the approach of dropping "timeout" is OK, but unless I
> say "you may add my ack after changing this and that", please do
> not automatically add my ack. Doesn't hurt here, since I have to
> pick it up anyway.

Sorry - my apologies! Removing for next re-post.

>> Changes since v4: * Removed OF timeout property (to be added
>> later when there is consensus about how to call and handle it) *
>> Changed clock-frequency example to decimal
> 
> Thanks, I just noticed. Please drop (more precise: remove) the 
> "slave-addr" for the same reasons as "timeout".

OK, will do.

>> ret = request_irq(alg_data->irq, i2c_pnx_interrupt, -			0,
>> pdev->name, alg_data); +			  0, pdev->name, alg_data);
> 
> I know that checkpatch complains about this, but I'd prefer to
> avoid such changes unless the code before was really unreadable.

OK!

Roland

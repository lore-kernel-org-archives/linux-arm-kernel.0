From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 11:26:32 +0200
Subject: [PATCH 1/3] net: lpc_eth: Replace WARN() trace with simple
 pr_warn()
In-Reply-To: <20120611.020352.1962768244524496467.davem@davemloft.net>
References: <1339401793-12258-1-git-send-email-stigge@antcom.de>
 <1339403108.6001.1697.camel@edumazet-glaptop> <4FD5AE1D.9030807@antcom.de>
 <20120611.020352.1962768244524496467.davem@davemloft.net>
Message-ID: <4FD5B9C8.4020800@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 06/11/2012 11:03 AM, David Miller wrote:
> From: Roland Stigge <stigge@antcom.de>
> Date: Mon, 11 Jun 2012 10:36:45 +0200
> 
>> But maybe this is wrong. Can you please give me a hint how the net
>> subsystem makes sure that this doesn't happen under normal circumstances?
> 
> Well if you are asking this question then you didn't read my feedback,
> because I explained exactly what prevents this.

Re-reading your feedback, you are right, sorry!

My question was based on the assumption that the driver is doing
correctly, which was wrong.

Thank you and Eric for clarifying!

Eric's second (cumulative) patch works fine for now, and I can't
reproduce the issue. Will do more test runs now and will reply back
later with an updated patch set.

Is it sensible at this point to increase the TX buffers anyway? For
different reasons of course: We have enough SRAM available and TX
buffers (16->32) are still more than RX buffers (48).

Roland

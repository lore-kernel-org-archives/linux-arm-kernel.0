From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 17 Sep 2018 17:59:40 +0200
Subject: [PATCH] net: macb: disable scatter-gather for macb on sama5d3
In-Reply-To: <20180917.075813.1145409055019392182.davem@davemloft.net>
References: <20180914154811.12090-1-nicolas.ferre@microchip.com>
 <20180917.075813.1145409055019392182.davem@davemloft.net>
Message-ID: <8da68995-4019-e0c7-0471-4fdbe40ad52a@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/2018 at 16:58, David Miller wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> Date: Fri, 14 Sep 2018 17:48:10 +0200
> 
>> Create a new configuration for the sama5d3-macb new compatibility string.
>> This configuration disables scatter-gather because we experienced lock down
>> of the macb interface of this particular SoC under very high load.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Applied, but are you really sure it isn't just some bug in the driver
> or somesuch?

Actually, the same IP on other SoCs behaves correctly with same driver. 
We tried hard to find the root cause of the problem without success and 
we didn't have confirmation of an issue on Cadence's side either.

The symptom is that we have a receive overrun on this interface under 
heavy load but I think that it is more a result of the issue than the 
real problem: I cannot escape from this overrun condition: the IP itself 
is completely blocked.

Even if the problem is very difficult to reproduce (simple *perf tools 
not sufficient), we play safe by simply disabling this feature on this 
SoC only.

Best regards,
-- 
Nicolas Ferre

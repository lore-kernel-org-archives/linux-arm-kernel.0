From: davem@davemloft.net (David Miller)
Date: Fri, 10 Aug 2018 19:11:53 -0700 (PDT)
Subject: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada 3700
In-Reply-To: <20180810222335.GD11955@lunn.ch>
References: <20180810113627.5dec5d40@xhacker.debian>
 <20180810.144031.861564620036768413.davem@davemloft.net>
 <20180810222335.GD11955@lunn.ch>
Message-ID: <20180810.191153.2290770424551316173.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 11 Aug 2018 00:23:35 +0200

> On Fri, Aug 10, 2018 at 02:40:31PM -0700, David Miller wrote:
>> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> Date: Fri, 10 Aug 2018 11:36:27 +0800
>> 
>> > The mvneta Ethernet driver is used on a few different Marvell SoCs.
>> > Some SoCs have per cpu interrupts for Ethernet events, the driver uses
>> > a per CPU napi structure for this case. Some SoCs such as armada 3700
>> > have a single interrupt for Ethernet events, the driver uses a global
>> > napi structure for this case.
>> > 
>> > Current mvneta_config_rss() always operates the per cpu napi structure.
>> > Fix it by operating a global napi for "single interrupt" case, and per
>> > cpu napi structure for remaining cases.
>> > 
>> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> > Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
>> 
>> Applied, thanks.
> 
> Hi David
> 
> Please can you queue up:
> 
> Fixes: 7a86f05faf11 ("net: ethernet: mvneta: Fix napi structure mixup on armada 3700")
> 
> and this patch for stable.

If you want things to go to -stable, don't mark them for net-next as this
patch was.

If it isn't appropriate for 'net' it isn't appropriate for -stable either.

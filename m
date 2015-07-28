From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jul 2015 09:27:38 +0200
Subject: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <20150720164241.GA5930@earth>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
 <20150720164241.GA5930@earth>
Message-ID: <55B72EEA.5020600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/07/2015 18:42, Sebastian Reichel a ?crit :
> Hi,
> 
> On Mon, Jul 20, 2015 at 05:32:05PM +0800, Josh Wu wrote:
>> This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
>> new reset function for sama5d3 and later chips.
>>
>> As in sama5d3 or later chips, we don't have to shutdown the DDR
>> controller before reset. Shutdown the DDR controller before reset is a
>> workaround to avoid DDR signal driving the bus, but since sama5d3 and
>> later chips there is no such a conflict.
>>
>> So in this patch:
>>    1. the sama5d3 reset function only need to write the rstc register
>> and return.
>>    2. we can remove the code related with sama5d3 DDR controller as
>> we don't use it at all.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> queued.

Sebastian,

As my Device Tree changes depend on this modification, we can
synchronize in tree ways:

1/ you provide me a stable branch so that I can pull it before applying
my changes that can go through arm-soc.

2/ you let me take the driver's modifications with me and the two
patches of the series would go through arm-soc.

3/ you take the second patch of my series with my Acked-by tag and carry
both of them up to Linus' tree.

Please tell me your preference.

Thanks, bye,
-- 
Nicolas Ferre

From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Oct 2015 17:53:40 +0300
Subject: [PATCH 10/13] dmaengine: ti-dma-crossbar: Add support for
 crossbar on AM33xx/AM43xx
In-Reply-To: <20151014144814.GW27370@localhost>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
 <1444828344-21378-11-git-send-email-peter.ujfalusi@ti.com>
 <20151014144814.GW27370@localhost>
Message-ID: <561E6C74.50502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 05:48 PM, Vinod Koul wrote:
> On Wed, Oct 14, 2015 at 04:12:21PM +0300, Peter Ujfalusi wrote:
>> The DMA event crossbar on AM33xx/AM43xx is different from the one found in
>> DRA7x family.
>> Instead of a single event crossbar it has 64 identical mux attached to each
>> eDMA event line. When the 0 event mux is selected, the default mapped event
>> is going to be routed to the corresponding eDMA event line. If different
>> mux is selected, then the selected event is going to be routed to the given
>> eDMA event.
> 
> Why is crossbar patch in edma series?

The old eDMA binding had xbar support which is not supported by the new
binding since it does not belong to the eDMA driver at all.
We have couple of boards where the crossbar is in use so I included the
crossbar support in this series.

>> +static void ti_am335x_xbar_free(struct device *dev, void *route_data)
>> +{
>> +	struct ti_am335x_xbar_data *xbar = dev_get_drvdata(dev);
>> +	struct ti_am335x_xbar_map *map = route_data;
>> +
>> +	dev_err(dev, "Unmapping XBAR event %u on channel %u\n",
>> +		map->mux_val, map->dma_line);
> 
> Err ?

Aargh, leftover from debugging.

-- 
P?ter

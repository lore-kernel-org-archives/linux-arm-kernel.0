From: afd@ti.com (Andrew F. Davis)
Date: Thu, 16 Nov 2017 09:53:59 -0600
Subject: [PATCH v2 1/4] omapdrm: fix compatible string for td028ttec1
In-Reply-To: <130D3B71-C0CE-4755-BF06-971681F630BC@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com>
 <4753a425-d050-7f2d-35ae-b387accfd99e@ti.com>
 <130D3B71-C0CE-4755-BF06-971681F630BC@goldelico.com>
Message-ID: <d90ee1ee-8a33-de04-bb8b-2f10e0a80a61@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2017 07:43 AM, H. Nikolaus Schaller wrote:
> 
>> Am 16.11.2017 um 13:32 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>>
>> On 16/11/17 10:50, H. Nikolaus Schaller wrote:
>>> The vendor name was "toppoly" but other panels and the vendor list
>>> have defined it as "tpo". So let's fix it in driver and bindings.
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>
>>
>>> -MODULE_ALIAS("spi:toppoly,td028ttec1");
>>> +MODULE_ALIAS("spi:tpo,td028ttec1");
>>
>> Doesn't this mean that the module won't load if you have old bindings?
> 
> Hm.
> 
> Well, I think it can load but doesn't automatically from DT strings which might
> be unexpected.
> 
>> Can't we have two module aliases?
> 
> I think we can. Just a random example:
> https://elixir.free-electrons.com/linux/latest/source/drivers/w1/slaves/w1_therm.c#L754
> 
> So we should keep both.

Even better would be to drop both MODULE_ALIAS and let the
MODULE_DEVICE_TABLE macro define them for your from the SPI id table.
Although it doesn't look like this driver has an SPI id table, you
should probably add one, I be interested to see if this module is always
being matched through the "spi" or the "of" alias..

> 
> Should I submit a new version?
> 
> BR,
> Nikolaus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

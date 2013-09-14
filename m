From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 14 Sep 2013 10:01:03 +0200
Subject: [PATCH] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <c6755ff6-104d-40fe-a753-0e165cff1e10@AM1EHSMHS004.ehs.local>
References: <1379033737-30015-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379033737-30015-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130913170005.GB5681@roeck-us.net>
 <c6755ff6-104d-40fe-a753-0e165cff1e10@AM1EHSMHS004.ehs.local>
Message-ID: <523417BF.7030505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 07:26 PM, S?ren Brinkmann wrote:
> On Fri, Sep 13, 2013 at 10:00:05AM -0700, Guenter Roeck wrote:
>> On Thu, Sep 12, 2013 at 05:55:37PM -0700, Soren Brinkmann wrote:
>>> Add a driver for SILabs 570, 571, 598, 599 programmable oscillators.
>>> The devices generate low-jitter clock signals and are reprogrammable via
>>> an I2C interface.
>>>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> ---
[...]
>>> diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
>>> new file mode 100644
>>> index 0000000..960d689
>>> --- /dev/null
>>> +++ b/drivers/clk/clk-si570.c
>>> @@ -0,0 +1,546 @@
[...]
>>> +	match = of_match_node(clk_si570_of_match, client->dev.of_node);
>>> +	if (!match)
>>> +		return -EINVAL;
>>
>> Seems unusual. Is this really needed ? It precludes the driver from being used
>> in a non-devicetree environment, for example. I would guess that there is a match
>> if client->dev.of_node is set. Otherwise, this code would be needed in every
>> driver supporting devicetree, and I don't recall seeing that.
>>
>>> +	ddata = match->data;
>>> +
>> You should be able to get this information (ie the pointer to si570_device_data)
>> from id->driver_data. That would be more consistent with other i2c devices.
> I think I copied this approach from the other clk-si... driver. I'll
> do some research on your suggestion and change it. Could you point me to
> an example for your proposal?

Soeren,

I sent a patch for the match removal in clk-si5351 [1].
Mike must have missed it, I will resend soon.
You can take that as "an example for the proposal" above.

Sebastian

[1] https://lkml.org/lkml/2013/9/3/484

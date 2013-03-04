From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 4 Mar 2013 12:19:10 -0600
Subject: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
In-Reply-To: <5134DF2A.4050209@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
 <CALF0-+V3A-fL7q2nPRmcgnFKmzRt8KwSLuzrwzyyce6MqHjVpw@mail.gmail.com>
 <5134DF2A.4050209@ti.com>
Message-ID: <5134E59E.1000507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/04/2013 11:51 AM, Jon Hunter wrote:
> 
> On 03/04/2013 05:57 AM, Ezequiel Garcia wrote:
>> Hi Jon,
>>
>> On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>> +
>>> +Example:
>>> +
>>> +gpmc: gpmc at 6e000000 {
>>> +       compatible = "ti,omap3430-gpmc", "simple-bus";
>>
>> I'm concern about using simple-bus, and I'm not entirely sure this will work.
>>
>> AFAIK, you can't correlate a parent-child relationship in the device tree
>> to the order in which drivers will be probed,
>> so it's only a matter of coincidence if this is working for you right now.
> 
> Ummm, I am not sure I am convinced. Have you looked at
> of_platform_bus_create() which creates the devices? It is clearly
> creating the child devices after creating the parent device.

Sorry you said order by which drivers are probed. Yes I would agree that
you cannot control the order drivers are probed, but just the order
devices are registered.

However, I don't see this as being a device-tree specific issue. Even
when not using device-tree you would need to ensure that probing the
parent happens before the child for the GPMC.

Jon

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 11 Sep 2014 11:56:54 -0400
Subject: [PATCH v2 0/3] net: Add Keystone NetCP ethernet driver support
In-Reply-To: <540DC00F.1080103@ti.com>
References: <1408115562-22487-1-git-send-email-santosh.shilimkar@ti.com>
 <20140821.163612.282672926741753926.davem@davemloft.net>
 <53F79DC5.8030003@ti.com> <540DC00F.1080103@ti.com>
Message-ID: <5411C646.6090701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

On Monday 08 September 2014 10:41 AM, Santosh Shilimkar wrote:
> Hi Dave,
> 
> On 8/22/14 3:45 PM, Santosh Shilimkar wrote:
>> Hi David,
>>
>> On Thursday 21 August 2014 07:36 PM, David Miller wrote:
>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Date: Fri, 15 Aug 2014 11:12:39 -0400
>>>
>>>> Update version after incorporating David Miller's comment from earlier
>>>> posting [1]. I would like to get these merged for upcoming 3.18 merge
>>>> window if there are no concerns on this version.
>>>>
>>>> The network coprocessor (NetCP) is a hardware accelerator that processes
>>>> Ethernet packets. NetCP has a gigabit Ethernet (GbE) subsystem with a ethernet
>>>> switch sub-module to send and receive packets. NetCP also includes a packet
>>>> accelerator (PA) module to perform packet classification operations such as
>>>> header matching, and packet modification operations such as checksum
>>>> generation. NetCP can also optionally include a Security Accelerator(SA)
>>>> capable of performing IPSec operations on ingress/egress packets.
>>>>
>>>> Keystone SoC's also have a 10 Gigabit Ethernet Subsystem (XGbE) which
>>>> includes a 3-port Ethernet switch sub-module capable of 10Gb/s and
>>>> 1Gb/s rates per Ethernet port.
>>>>
>>>> NetCP driver has a plug-in module architecture where each of the NetCP
>>>> sub-modules exist as a loadable kernel module which plug in to the netcp
>>>> core. These sub-modules are represented as "netcp-devices" in the dts
>>>> bindings. It is mandatory to have the ethernet switch sub-module for
>>>> the ethernet interface to be operational. Any other sub-module like the
>>>> PA is optional.
>>>>
>>>> Both GBE and XGBE network processors supported using common driver. It
>>>> is also designed to handle future variants of NetCP.
>>>
>>> I don't want to see an offload driver that doesn't plug into the existing
>>> generic frameworks for configuration et al.
>>>
>>> If no existing facility exists to support what you need, you must work
>>> with the upstream maintainers to design and create one.
>>>
>>> It is absolutely no reasonable for every "switch on a chip" driver to
>>> export it's own configuration knob, we need a standard interface all
>>> such drivers will plug into and provide.
>>>
As discussed on other thread, we are dropping the custom exports. I
will be spinning updated version with the exports removed.

And for the future offload support additions, we will plug into
generic frameworks as when they are available.

Regards,
Santosh

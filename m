From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 6 Aug 2014 10:43:19 -0500
Subject: [Regression] FEC: Panic on suspend in 3.16
In-Reply-To: <53E24A99.2020604@denx.de>
References: <53E24147.4050304@parkeon.com> <53E24525.2020809@mentor.com>
 <53E24A99.2020604@denx.de>
Message-ID: <53E24D17.90704@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2014 10:32 AM, Stefano Babic wrote:
> Hi Nathan, Martin,
> 
> On 06/08/2014 17:09, Nathan Lynch wrote:
>> On 08/06/2014 09:52 AM, Martin Fuzzey wrote:
>>> Hi all,
>>>
>>> I am using the fec ethernet driver on a i.MX53 SoC.
>>>
>>> All was working fine on 3.13 but, after upgrading to 3.16 I now get a
>>> panic on suspend:
>>
>> Same issue reported here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277728.html
>>
>> a71e3c37960c (net: phy: Set the driver when registering an MDIO bus
>> device) has been implicated; try reverting that.
>>
> 
> I confirm this issue (on a i.MX35). The ndev pointer is NULL in the
> suspend function. I added the check for the pointer:

I'm not sure this is the right fix.  The fec driver's suspend function
is being called for a device it did not probe (I verified this on mx6q).

See Russell's explanation here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277823.html

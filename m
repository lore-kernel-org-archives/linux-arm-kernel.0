From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Dec 2017 07:02:09 -0800
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171228100519.GE2626@kwain>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171228074623.GA28444@lunn.ch> <20171228100519.GE2626@kwain>
Message-ID: <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/28/2017 02:05 AM, Antoine Tenart wrote:
> Hi Andrew,
> 
> On Thu, Dec 28, 2017 at 08:46:23AM +0100, Andrew Lunn wrote:
>> On Wed, Dec 27, 2017 at 10:24:01PM +0000, Russell King - ARM Linux wrote:
>>> On Wed, Dec 27, 2017 at 11:14:45PM +0100, Antoine Tenart wrote:
>>>>  
>>>> +&cps_eth2 {
>>>> +	/* CPS Lane 5 */
>>>> +	status = "okay";
>>>> +	phy-mode = "2500base-x";
>>>> +	/* Generic PHY, providing serdes lanes */
>>>> +	phys = <&cps_comphy5 2>;
>>>> +};
>>>> +
>>>
>>> This is wrong.  This lane is connected to a SFP cage which can support
>>> more than just 2500base-X.  Tying it in this way to 2500base-X means
>>> that this port does not support conenctions at 1000base-X, despite
>>> that's one of the most popular and more standardised speeds.
>>>
>>
>> I agree with Russell here. SFP modules are hot pluggable, and support
>> a range of interface modes. You need to query what the SFP module is
>> in order to know how to configure the SERDES interface. The phylink
>> infrastructure does that for you.
> 
> Sure, I understand. We'll be able to support such interfaces only when
> the phylink PPv2 support lands in.

Should we expect PHYLINK support to make it as the first patch in your
v2 of this patch series, or is someone else doing that?
-- 
Florian

From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 24 Nov 2014 15:32:52 +0100
Subject: FIX ME in xsysace.c
In-Reply-To: <54731648.8010006@gmail.com>
References: <5472B1D6.7080805@gmail.com>
 <5a8be93a4204429daf16bc8f62cdd0cd@BY2FFO11FD005.protection.gbl>
 <54731648.8010006@gmail.com>
Message-ID: <5e95919de4e349a6a7c5261cb1e9fda5@BN1BFFO11FD012.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/24/2014 12:28 PM, nick wrote:
> 
> 
> On 14-11-24 02:47 AM, Michal Simek wrote:
>> Hi,
>>
>> On 11/24/2014 05:19 AM, nick wrote:
>>> Greetings Michal and others,
>>> I am wondering about the FIX ME in xsysace.c as it seems not correct due to my knowledge of most hardware protocols using a predetermined bit wide and therefore this could be hard coded. If someone can respond on if I am correct in removing this fix me it would be greatly appreciated.
>>
>> I think that will be the best to c&p that fixme which you are talking about.
>> Definitely feel free to fix whatever fixme is there and send the patch
>> for fixing it.
>>
>> Thanks,
>> Michal
>>
> Here is the fix me.
> int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */

FIXME is totally bogus and should be removed.

I expect you want to use 8bit bus mode which driver itself supports.
This line is just default setup to 16bit mode.

If you add 8-bit property to dts you are there.
	if (of_find_property(dev->dev.of_node, "8-bit", NULL))
		bus_width = ACE_BUS_WIDTH_8;

Thanks,
Michal

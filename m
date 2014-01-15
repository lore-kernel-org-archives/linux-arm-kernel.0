From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 15 Jan 2014 12:09:02 -0800
Subject: [PATCH 4/6] ARM: DTS: tegra: add the DFLL IP block to the T114
 SoC file
In-Reply-To: <20140115195025.GU20094@book.gsilab.sittig.org>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123719.3226.44864.stgit@tamien> <52B389CD.8010004@wwwdotorg.org>
 <alpine.DEB.2.02.1401132219150.11672@tamien>
 <20140115195025.GU20094@book.gsilab.sittig.org>
Message-ID: <52D6EADE.3020004@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2014 11:50 AM, Gerhard Sittig wrote:
> On Mon, Jan 13, 2014 at 22:27 -0800, Paul Walmsley wrote:
>> On Thu, 19 Dec 2013, Stephen Warren wrote:
>>
>>> On 12/19/2013 05:49 AM, Paul Walmsley wrote:
>>>> Add basic DT bindings for the DFLL IP block for the NVIDIA Tegra114 SoC.
>>>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
>>>> +- clocks : Must contain an array of two-cell arrays, one per clock.
>>>> +           DFLL source clocks.  At minimum this should include the
>>>> +           reference clock source and the IP block's main clock
>>>> +           source.  Also it should contain the DFLL's I2C controller
>>>> +           clock source.  The format is <&clock-provider-phandle
>>>> +           clock-id>.
>>> Entries in "clocks" aren't two cells, they're a phandle plus as many
>>> cells as the node referenced by the phandle specifies.
>> It's worth noting that the clock binding documentation itself refers
>> to pairs:
>>
>> ----
>>
>> clocks:		List of phandle and clock specifier pairs, one pair
>> 		for each clock input to the device.  Note: if the
>> 		clock provider specifies '0' for #clock-cells, then
>> 		only the phandle portion of the pair will appear.
>>
>> ----
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/clock-bindings.txt#n50
>>
>> But given the ambiguity of that documentation, I basically agree, so
>> have changed it to:
> Please note that there neither is an ambiguity nor a conflict
> here, and that you actually acknowledge what Stephen said:

I do not agree that the Documentation is unambiguous.

It is not correct to refer to a "pair" without a second item as a "pair."

> This is exactly what Stephen said:  A "clocks" item does not need
> to have two cells.  The pair of phandle and clock specifier don't
> necessarily translate into two cells, instead the number of cells
> depends on the clock provider.

I do agree with this, and have updated the documentation accordingly.


- Paul

From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Jan 2012 17:20:36 -0800
Subject: [PATCH 7/9] arm/tegra: emc: device tree bindings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F18A6@HQMAIL01.nvidia.com>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-8-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18A6@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMjeVm_PcsBnxfKX9Oe96QUaCsJrvuESCRZq5vwq9gD5xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 4:01 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
>> Device tree bindings for the EMC tables on tegra.
> ...
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/emc.txt
> ...
>> +Embedded Memory Controller ram-code table
> ...
>> +- name : Should be emc-tables
>> +- nvidia,ram-code : the binary representation of the ram-code board strappings
>> + ?for which this node (and children) are valid.
> ...
>> +Embedded Memory Controller configuration table
> ...
>> +- name : Should be emc-table
>> +- compatible : Should contain "nvidia,tegra20-emc-table".
>> +- reg : either an opaque enumerator to tell different tables apart, or
> ...
>
> One more thought:
>
> For consistency, should the "emc-tables" node also require a compatible
> value? I suppose the existence of an "nvidia,ram-code" property is quite
> likely to be indication enough that the node is compatible, but I wonder
> if we shouldn't require and check an explicit compatible value at this
> level too?

I can add it, it's trivial to add another check in
tegra_emc_ramcode_devnode, but I don't think there's much need to
bother. As long as nothing else is added that uses nvidia,ram-code as
a property we'll be OK, and we can control that.


-Olof

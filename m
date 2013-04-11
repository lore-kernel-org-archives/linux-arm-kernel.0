From: rklein@nvidia.com (Rhyland Klein)
Date: Thu, 11 Apr 2013 11:38:47 -0400
Subject: [PATCH] ARM: tegra: Add charger subnode to tps65090 node
In-Reply-To: <5165E80D.7050106@wwwdotorg.org>
References: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
 <5165E80D.7050106@wwwdotorg.org>
Message-ID: <5166D907.6060004@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/10/2013 6:30 PM, Stephen Warren wrote:
> On 04/10/2013 01:51 PM, Rhyland Klein wrote:
>> The charger is now represented by a distinct subnode of the tps65090
>> device. Add this node and enable low current charging with it.
> 
>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> 
>> +			charger {
>> +				compatible = "ti,tps65090-charger";
>> +				ti,enable-low-current-chrg;
> 
> So does the TPS65090 driver scan all its sub-nodes like a bus an
> instantiate anything? That's a little odd since the regulators node is
> at the same level, yet doesn't represent a device on that same internal
> bus...
> 

It doesn't scan so much as have a list of subdev's it tries to register.
The charger node uses the of_compatible string defined (in the tps65090
driver and the charger driver) to match the subnode to the mfd_cell
device for the charger. The regulators are currently under a different
subdevice which is not using the of_compatible string. I was planning on
a follow up patch series to update the tps65090-regulator driver to use
the dt type approach with a subnode to be consistent.

-rhyland

-- 
nvpublic

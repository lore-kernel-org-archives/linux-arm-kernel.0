From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 12:28:57 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <20120611103606.GG11439@opensource.wolfsonmicro.com>
References: <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
 <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
 <4FC846CC.20801@linaro.org>
 <20120601084850.GJ24139@opensource.wolfsonmicro.com>
 <4FCDDFFC.3000902@linaro.org>
 <20120605103846.GQ23408@opensource.wolfsonmicro.com>
 <4FD5C829.2090408@linaro.org>
 <20120611103606.GG11439@opensource.wolfsonmicro.com>
Message-ID: <4FD5D679.1070000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 11:36, Mark Brown wrote:
> On Mon, Jun 11, 2012 at 11:27:53AM +0100, Lee Jones wrote:
>> On 05/06/12 11:38, Mark Brown wrote:
>
>>> You're missing something - note what I say above about the direction the
>>> mapping is done in, and consider what happens if we've got two of the
>>> same PMIC down in a system.
>
>> I'm still not seeing how this would cause an issue. The only Device
>> Tree nodes which will be parsed are the ones which are specified by
>> a particular driver's compatible string, meaning that any other
>> nodes referencing similar regulator/supply names would be ignored.
>
> Suppose you have two devices of the same type with an array of name
> based regulators, meaning the nodes with constraints have to have a
> particular name in order to be matched to the regulator.  How would a
> consumer reference a node to specify a supply?

some-regulators {
     compatible = "protect_me_from_similarly_named_regulators";

     regulator_node_name_reg: regulator_node_name {
         <blah>
     };
};

[supply_name]-supply = <&regulator_node_name>;

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

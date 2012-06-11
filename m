From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jun 2012 19:42:40 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <4FD5D679.1070000@linaro.org>
References: <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
 <4FC846CC.20801@linaro.org>
 <20120601084850.GJ24139@opensource.wolfsonmicro.com>
 <4FCDDFFC.3000902@linaro.org>
 <20120605103846.GQ23408@opensource.wolfsonmicro.com>
 <4FD5C829.2090408@linaro.org>
 <20120611103606.GG11439@opensource.wolfsonmicro.com>
 <4FD5D679.1070000@linaro.org>
Message-ID: <20120611114239.GL11439@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 12:28:57PM +0100, Lee Jones wrote:
> On 11/06/12 11:36, Mark Brown wrote:

> >Suppose you have two devices of the same type with an array of name
> >based regulators, meaning the nodes with constraints have to have a
> >particular name in order to be matched to the regulator.  How would a
> >consumer reference a node to specify a supply?

> some-regulators {
>     compatible = "protect_me_from_similarly_named_regulators";
> 
>     regulator_node_name_reg: regulator_node_name {
>         <blah>
>     };
> };

> [supply_name]-supply = <&regulator_node_name>;

I'm not 100% sure you read what I wrote above or in all the previous
mails about having two devices of the same type?  The case where we have
only one regulator of a given type obviously works otherwise people
would have noticed, the problem starts when you have two of the same
regulator device down.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120611/1ece3d2b/attachment-0001.sig>

From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 05 Dec 2011 15:45:04 +0200
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <20111203112206.GE6043@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111203112206.GE6043@opensource.wolfsonmicro.com>
Message-ID: <4EDCCAE0.2000009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2011 01:22 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:
> 
>> @@ -0,0 +1,13 @@
>> +* Texas Instruments OMAP4 Digital Microphone Module
>> +
>> +Required properties:
>> +  - compatible : "ti,omap4-dmic"
>> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
>> +		 it is "dmic".
> 
> Actually thinking about this some more I think what's concerning me is
> the documentation as much as anything else - if it was just an internal,
> unpublished interface of the OMAP core code which happened to use device
> tree I probably wouldn't have worried about it churning.

Actually it is documented here:
Documentation/devicetree/bindings/arm/omap/omap.txt

In order to move all OMAP drivers to DT - as Benoit already mentioned -
we need additional work in DT.
At this point of time if we add the DT representation we anyways need to
change it as the core will receive the features, and we still need to
fall back to hwmod to get the drivers working.
As soon as we can migrate away from the hwmod we will do, but having
this in place helps us to migrate other parts to DT.

-- 
P?ter

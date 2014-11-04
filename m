From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Tue, 4 Nov 2014 22:21:24 +0100
Subject: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings
 documentation
In-Reply-To: <553e634f-ce75-4409-883c-acbfe773e950@googlegroups.com>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home> <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
 <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home>
 <553e634f-ce75-4409-883c-acbfe773e950@googlegroups.com>
Message-ID: <20141104222124.1bc7e6ec@neptune.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezaul,

On Tue, 04 November 2014 Ezaul Zillmer <ezaulzillmer@gmail.com> wrote:
> Cubieboard2  + Kernel 3.18-rc3
> 
> [   15.955655] axp20x-regulator axp20x-regulator: regulators node not found
> [   15.962580] LDO1: 1300 mV
> [   15.965732] LDO2: at 3000 mV
> [   15.969120] LDO3: at 2275 mV
> [   15.972314] LDO4: at 2800 mV
> [   15.975700] LDO5: at 2800 mV
> [   15.979075] DCDC2: at 1400 mV
> [   15.982555] DCDC3: at 1250 mV
> [   15.985706] axp20x 0-0034: AXP20X driver loaded
> 
> What was missing for axp20x work of cubieboard2 dt? 
> as poderiar do to run this drive? 

Not sure what patches, it at all you have on top of 3.18-rc3.
As far as I know 3.18 should not have any AXP driver that's
not already present in 3.17.

The base AXP driver only includes power-off support and bits for
regulators while the DT part of regulators is missing (at least
for cubietruck).

My patches, ideally combined with Carlo's patches from June or so
I mentioned in introduction mail would include power supply and 
input driver for power button. The regulator DT entries are in some
other patch (I think Maxime did have them in some of his trees -
probably defining them causes too much trouble because all uses are
not yet ready to explicitly use them).

On DT side, on top of my patches, for cubieboard2 you might need to
add the backup battery property if it has such a battery - I don't
think the CB2 has a main battery connector but I might be wrong
(I only have a cubietruck).

Except for that a hwmon driver would be useful to cover some of the
last bits of the AXP like temprature sensor and main voltage sensor.
With that about all the features should be covered.

Bruno

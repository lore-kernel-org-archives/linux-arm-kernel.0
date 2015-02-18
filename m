From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Feb 2015 12:10:05 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <20150218104023.GA22296@x1>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-2-git-send-email-antoine.tenart@free-electrons.com>
 <20150216124808.GC14545@x1> <20150217092020.GC4507@kwain>
 <20150217115447.GA3989@x1> <20150218084004.GD21937@kwain>
 <20150218090958.GA18042@x1> <20150218092225.GE21937@kwain>
 <20150218104023.GA22296@x1>
Message-ID: <54E4730D.1060507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.02.2015 11:40, Lee Jones wrote:
> On Wed, 18 Feb 2015, Antoine Tenart wrote:
[...]
>> chip: chip-controller at ea0000 {
>>          compatible = "marvell,berlin2q-chip-ctrl", "syscon";
>>          reg = <0xea0000 0x400>, <0xdd0170 0x10>;
>>          #clock-cells = <1>;
>>          clocks = <&refclk>;
>>          clock-names = "refclk";
>>
>>          soc_pinctrl: pin-controller {
>>                  compatible = "marvell,berlin2q-soc-pinctrl";
>>
>>                  twsi0_pmux: twsi0-pmux {
>>                          groups = "G6";
>>                          function = "twsi0";
>>                  };
>>
>>                  twsi1_pmux: twsi1-pmux {
>>                          groups = "G7";
>>                          function = "twsi1";
>>                  };
>>          };
>>
>>          chip_rst: reset {
>>                  compatible = "marvell,berlin2-reset";
>>                  #reset-cells = <2>;
>>          };
>> };
>
> This is what I'd expect to see in DT, so we're heading in the right
> direction.  So make to my original question, what's the point of this
> MFD driver, and why don't you just let DT framework register these
> devices for you?
>
> You issue a compatible string here, then duplicate it in the driver,
> why do you think this is necessary?

Lee,

there is no DT framework that automatically probes for
compatible<->driver matches. You either make it "simple-bus" compatible
which will call of_foo_populate() or you have to register each of the
devices yourself. It clearly is not a bus, so if we use this as a
workaround, we'll get yelled at by others.

Sebastian

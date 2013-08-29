From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 29 Aug 2013 18:13:55 +0400
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130829113848.6d8f7f21@armhf>
References: <20130828113459.48ecbb34@armhf>
 <521E5438.90109@cogentembedded.com> <20130829113848.6d8f7f21@armhf>
Message-ID: <521F5723.6070408@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 29-08-2013 13:38, Jean-Francois Moine wrote:

>>> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
>>> index 499abad..78227e2 100644
>>> --- a/arch/arm/boot/dts/dove.dtsi
>>> +++ b/arch/arm/boot/dts/dove.dtsi
>>> @@ -573,6 +573,24 @@
>>>    					phy-handle = <&ethphy>;
>>>    				};
>>>    			};
>>> +
>>> +			i2s0: audio-controller at b0000 {

>>       According to ePAPR [1] the node should be called "sound", not
>> "audio-controller".

>>> +				compatible = "marvell,mvebu-audio";
>>> +				reg = <0xb0000 0x2210>;
>>> +				interrupts = <19>, <20>;
>>> +				clocks = <&gate_clk 12>;
>>> +				clock-names = "internal";
>>> +				status = "disabled";
>>> +			};

> AFAIK, "sound" describes the global audio subsystem. For the Cubox,
> this will be done by something like:

> 	sound {
> 		compatible = "simple-audio";
> 		audio-controller = <&i2s1>;
> 		audio-codec = <&spdif>;
> 		codec-dai-name = "dit-hifi";
> 	};

    Well, then "sound-controller" sounds somewhat more appropriate.

WBR, Sergei

From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 29 Oct 2012 14:38:17 +0800
Subject: [PATCH 4/5] ASoC: sam9g20_wm8731: convert to device tree support
In-Reply-To: <20121027221204.GL4564@opensource.wolfsonmicro.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
 <20121027221204.GL4564@opensource.wolfsonmicro.com>
Message-ID: <508E2459.5090707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 6:12, Mark Brown wrote:
> On Mon, Oct 22, 2012 at 06:17:58PM +0800, Bo Shen wrote:
>> Covert sam9g20 wm8731 to device tree support
>> And enable it through dts file
>>
>>    Tested on sam9g20 EK board
>
> This needs to add binding documentation for the board.

I will add the binding documentation in next version.

>> +	dai: dai {
>> +		compatible = "atmel,atmel-ssc-dai";
>> +		atmel,dai-master = <&ssc0>;
>> +	};
>
> This looks wrong - this is a Linux-specific virtual device sitting on
> top of the SSC which is the actual physical device.  The usual patterns
> would be something like have the machine driver register the DAI based
> on the SSC specified in the bindings (much like how you're handling the
> platform already).

I have a question for this, do all nodes in dts file should be physical 
device?

The SSC part is a little different with other SoC family. So, I think, 
if I keep the ssc driver in driver/misc folder as the library code. And 
create new code into sound/soc/atmel for ssc which used for audio, would 
this be acceptable? If so, the framework will be the same with other SoC 
family.

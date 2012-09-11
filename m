From: ola.o.lilja@stericsson.com (Ola Lilja)
Date: Tue, 11 Sep 2012 11:06:00 +0200
Subject: [PATCH 06/17] Documentation: Define the MOP500 Audio Machine
 Driver Device Tree bindings
In-Reply-To: <20120910164413.GC24506@gmail.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-7-git-send-email-lee.jones@linaro.org>
 <20120910164413.GC24506@gmail.com>
Message-ID: <504EFEF8.6020707@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 06:44 PM, Lee Jones wrote:

> Ola poke.
> 
> On Fri, Aug 24, 2012 at 03:01:42PM +0100, Lee Jones wrote:
>> Here we add the required documentation for the new Device Tree
>> bindings pertaining to the MOP500 Audio Machine driver.
>> 
>> CC: alsa-devel at alsa-project.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>  .../devicetree/bindings/sound/ux500-mop500.txt     |   39 ++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/ux500-mop500.txt b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
>> new file mode 100644
>> index 0000000..48e071c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/ux500-mop500.txt
>> @@ -0,0 +1,39 @@
>> +* MOP500 Audio Machine Driver
>> +
>> +This node is responsible for linking together all ux500 Audio Driver components.
>> +
>> +Required properties:
>> + - compatible              : "stericsson,snd-soc-mop500"
>> +
>> +Non-standard properties:
>> + - stericsson,cpu-dai      : Phandle to the CPU-side DAI
>> + - stericsson,audio-codec  : Phandle to the Audio CODEC
>> + - stericsson,card-name    : Over-ride default card name
>> +
>> +Example:
>> +
>> +	sound {
>> +		compatible = "stericsson,snd-soc-mop500";
>> +
>> +		stericsson,cpu-dai = <&msp1 &msp3>;
>> +		stericsson,audio-codec = <&codec>;
>> +	};
>> +
>> +	msp1: msp at 80124000 {
>> +		compatible = "stericsson,ux500-msp-i2s";
>> +		reg = <0x80124000 0x1000>;
>> +		interrupts = <0 62 0x4>;
>> +		v-ape-supply = <&db8500_vape_reg>;


I'm no DT-expert, but why are you adding MSP-stuff in the machine-driver? They
are also added in the next patch.

>> +	};
>> +
>> +	msp3: msp at 80125000 {
>> +		compatible = "stericsson,ux500-msp-i2s";
>> +		reg = <0x80125000 0x1000>;
>> +		interrupts = <0 62 0x4>;
>> +		v-ape-supply = <&db8500_vape_reg>;
>> +	};
>> +
>> +	codec: ab8500-codec {
>> +		compatible = "stericsson,ab8500-codec";
>> +		stericsson,earpeice-cmv = <950>; /* Units in mV. */


Only four voltages are allowed here. Maybe enumerate them in the comment?

>> +	};
>> -- 
>> 1.7.9.5
>> 
> 

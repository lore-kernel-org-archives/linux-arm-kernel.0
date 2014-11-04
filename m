From: D.Lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Tue, 4 Nov 2014 11:40:32 +0000
Subject: [PATCH v5 2/3] ARM: dts: pbab01: enable I2S audio on
 phyFLEX-i.MX6 boards
In-Reply-To: <20141103061408.GA21210@tiger>
References: <1414590424-25585-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1414590424-25585-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <20141103061408.GA21210@tiger>
Message-ID: <76742380-95D6-4E0C-8622-E9FA27993A42@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 3Nov, 2014, at 09:14, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Oct 29, 2014 at 04:47:03PM +0300, Dmitry Lavnikevich wrote:
>> +		fsl,audmux-port = <4>;
>> +		fsl,port-config = <
>> +			0x00000000
>> +			IMX_AUDMUX_V2_PDCR_RXDSEL(1)
>> +		>;
>> +	};
>> +};
>> +
>> &i2c2 {
>> 	status = "okay";
>> 
>> -	tlv320 at 18 {
>> -		compatible = "ti,tlv320aic3x";
>> +	codec: tlv320 at 18 {
>> +		compatible = "ti,tlv320aic3007";
> 
> Both compatible strings are documented in
> Documentation/devicetree/bindings/sound/tlv320aic3x.txt.  But I hope
> this change will not cause any DT compatible issues.

This change is needed because unlike other tlv320aic3x-codecs tlv320aic3007 has D-class amplifier which is controlled by set of registers that in case of 3x-codecs control mono output.

I will correct patches according to other notes and soon will resend patchset.

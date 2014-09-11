From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 11 Sep 2014 11:44:39 +0200
Subject: [PATCH v4 1/3] ARM: dts: Add Peach Pit dts entry for Atmel
 touchpad
In-Reply-To: <20140910222553.GF38736@core.coreip.homeip.net>
References: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410348691-18317-2-git-send-email-javier.martinez@collabora.co.uk>
 <20140910222553.GF38736@core.coreip.homeip.net>
Message-ID: <54116F07.9090007@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dmitry,

On 09/11/2014 12:25 AM, Dmitry Torokhov wrote:
>>  
>> +&hsi2c_8 {
>> +	status = "okay";
>> +	clock-frequency = <333000>;
>> +
>> +	/* Atmel mXT336S */
>> +	trackpad at 4b {
>> +		compatible = "atmel,maxtouch";
>> +		reg = <0x4b>;
>> +		interrupt-parent = <&gpx1>;
>> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
>> +		wakeup-source;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&trackpad_irq>;
>> +		linux,gpio-keymap = <KEY_RESERVED
>> +				     KEY_RESERVED
>> +				     KEY_RESERVED	/* GPIO0 */
>> +				     KEY_RESERVED	/* GPIO1 */
>> +				     KEY_RESERVED	/* GPIO2 */
>> +				     BTN_LEFT>; 	/* GPIO3 */
> 
> Seems like a single space sneaked between the semicolon and the tab.
> Maybe whoever applies could squash it.
> 

Right, I set c-default-style to "linux" on Emacs but seems it gets confused
sometimes when editing Device Tree source files. Sorry about that.

Best regards,
Javier

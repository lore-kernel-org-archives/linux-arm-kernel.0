From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 14 Sep 2014 01:36:34 +0900
Subject: [PATCH v4 1/3] ARM: dts: Add Peach Pit dts entry for Atmel
 touchpad
In-Reply-To: <54116F07.9090007@collabora.co.uk>
References: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410348691-18317-2-git-send-email-javier.martinez@collabora.co.uk>
 <20140910222553.GF38736@core.coreip.homeip.net>
 <54116F07.9090007@collabora.co.uk>
Message-ID: <54147292.2000901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/14 18:44, Javier Martinez Canillas wrote:
> Hello Dmitry,
>
Hi,

> On 09/11/2014 12:25 AM, Dmitry Torokhov wrote:
>>>
>>> +&hsi2c_8 {
>>> +	status = "okay";
>>> +	clock-frequency =<333000>;
>>> +
>>> +	/* Atmel mXT336S */
>>> +	trackpad at 4b {
>>> +		compatible = "atmel,maxtouch";
>>> +		reg =<0x4b>;
>>> +		interrupt-parent =<&gpx1>;
>>> +		interrupts =<1 IRQ_TYPE_EDGE_FALLING>;
>>> +		wakeup-source;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 =<&trackpad_irq>;
>>> +		linux,gpio-keymap =<KEY_RESERVED
>>> +				     KEY_RESERVED
>>> +				     KEY_RESERVED	/* GPIO0 */
>>> +				     KEY_RESERVED	/* GPIO1 */
>>> +				     KEY_RESERVED	/* GPIO2 */
>>> +				     BTN_LEFT>; 	/* GPIO3 */
>>
>> Seems like a single space sneaked between the semicolon and the tab.
>> Maybe whoever applies could squash it.
>>
>
> Right, I set c-default-style to "linux" on Emacs but seems it gets confused
> sometimes when editing Device Tree source files. Sorry about that.
>
Applied this whole series with fixing a white space Dmitry commented.

Note, I will handle all of exynos_defconfig changes separately.

Thanks,
Kukjin

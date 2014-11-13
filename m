From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 12:15:35 +0100
Subject: [PATCH v2 13/14] ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
In-Reply-To: <1415876417-28728-14-git-send-email-peter.griffin@linaro.org>
References: <1415876417-28728-1-git-send-email-peter.griffin@linaro.org>
 <1415876417-28728-14-git-send-email-peter.griffin@linaro.org>
Message-ID: <3348806.YN8XP4V4uc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 11:00:16 Peter Griffin wrote:
> +       soc {
> +               usb2_picophy0: usbpicophy at 0 {
> +                       compatible = "st,stih407-usb2-phy";
> +                       reg = <0xf8 0x04>,      /* syscfg 5062 */
> +                             <0xf4 0x04>;      /* syscfg 5061 */
> 

I think the node name for the phy should be "phy at f8" instead of usbpicophy at 0
by common convention. I notice that there are some existing instances of
this, you can probably change them as well. Linux doesn't normally care
about the node names.

It also seems that you have put the node in the wrong place, as the reg
property apparently refers to a different address space. Did you mean
to put this under the syscfg_core node?

	Arnd

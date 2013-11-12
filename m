From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Nov 2013 15:11:09 -0500
Subject: [PATCHv2] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <87ppq5flnb.fsf@natisbad.org>
References: <87ppq5flnb.fsf@natisbad.org>
Message-ID: <20131112201109.GT10335@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 08:46:48PM +0100, Arnaud Ebalard wrote:
> 
> All hardware parts of the (mv78230 Armada XP based) NETGEAR ReadyNAS
> 2120 are supported by mainline kernel (USB 3.0 and eSATA rear ports,
> USB 2.0 front port, Gigabit controller and PHYs for the two rear ports,
> serial port, LEDs, Buttons, 88SE9170 SATA controllers, three G762 fan
> controllers, G751 temperature sensor) except for:
> 
>  - the Intersil ISL12057 I2C RTC Chip,
>  - the Armada NAND controller.
> 
> Support for both of those is currently work in progress and does not
> prevent boot.
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> Hi,
> 
> Initial message:
>  
>   This one is intended for v3.14. This depends on the recent fix I pushed
>   for mv78230 PCIe and also on a small patch Guenter Roeck just accepted
>   to have lm75 driver support GMT G751 Temperature sensor (see 
>   https://lkml.org/lkml/2013/11/9/273).
>   
>   Regarding the SATA presence and power pin definitions under pinctrl
>   node if you wonder, I thought it would not harm to have them for
>   reference even though they are currently not used. FWIW, I am currently
>   looking if a GPIO regulator can make any use of those.
>  
> 
> Note changed since v2 (i.e. kept for later cleanup session):

I presume s/Note/Not/ ?  Otherwise, I'm really confused. :)

>  - move clocks = <&coreclk 0> in serial node to armada-370-xp.dtsi
>  - add a label to most SoC nodes to avoid replaying the whole node hierarchy
>  - see if g762 dt binding can be fixed (no remarks done during review)

thx,

Jason.

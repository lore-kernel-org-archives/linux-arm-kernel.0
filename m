From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 11 Jul 2014 19:53:54 +0200
Subject: [PATCH] can: flexcan: add vf61x support for flexcan
In-Reply-To: <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
References: <1405075933-22317-1-git-send-email-stefan@agner.ch>
 <53BFD401.8030101@pengutronix.de> <dac76ccd134f41b86f00352d10cfae4b@agner.ch>
Message-ID: <53C024B2.60404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2014 03:58 PM, Stefan Agner wrote:
> Hi Marc,
> 
> Am 2014-07-11 14:09, schrieb Marc Kleine-Budde:
>> IMHO it should be 4 seperate patches:
>> - dt
>> - clocks
>> - flexcan_get_berr_counter fixes
>> - your flexcan enhancements
> 
> Ok, will split.
> 
>>> @@ -362,7 +374,7 @@
>>>
>>>  			esdhc1: esdhc at 400b2000 {
>>>  				compatible = "fsl,imx53-esdhc";
>>> -				reg = <0x400b2000 0x4000>;
>>> +				reg = <0x400b2000 0x1000>;
>>
>> What's that doing here? :)
> 
> That's an error I just stumbled upon. I know it's not related but it's
> such a small change... Do I need to make a separate patch for that or
> can I include it in the FlexCAN dt commit?

Yes, please post it to Shawn (& linux-arm) directly.

> 
>>> @@ -150,18 +171,20 @@
>>>   * FLEXCAN hardware feature flags
>>>   *
>>>   * Below is some version info we got:
>>> - *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT
>>> - *                                Filter?   connected?
>>> - *   MX25  FlexCAN2  03.00.00.00     no         no
>>> - *   MX28  FlexCAN2  03.00.04.00    yes        yes
>>> - *   MX35  FlexCAN2  03.00.00.00     no         no
>>> - *   MX53  FlexCAN2  03.00.00.00    yes         no
>>> - *   MX6s  FlexCAN3  10.00.12.00    yes        yes
>>> + *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT  Memory err
>>> + *                                Filter?   connected?  detection
>>> + *   MX25  FlexCAN2  03.00.00.00     no         no	   no
>>> + *   MX28  FlexCAN2  03.00.04.00    yes        yes	   no
>>> + *   MX35  FlexCAN2  03.00.00.00     no         no	   no
>>> + *   MX53  FlexCAN2  03.00.00.00    yes         no	   no
>>> + *   MX6s  FlexCAN3  10.00.12.00    yes        yes	   no
>>> + *   VFxx  FlexCAN3  ?		     no		no	  yes
>>
>> Please use either tabs or space to indent in this table.
> 
> Ok, btw, do you know how I can obtain the IP version?

Get in touch with a freescale engineer with VHDL access, meet in a
bar...ask her/him....Something like this :)

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/2416b72f/attachment.sig>

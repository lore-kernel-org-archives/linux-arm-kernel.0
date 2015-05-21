From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 21 May 2015 16:05:33 +0200
Subject: [PATCH 1/2] phy: add lpc18xx usb otg phy driver
In-Reply-To: <555DD5CB.4040805@ti.com>
References: <1431797277-4906-1-git-send-email-manabian@gmail.com>
 <1431797277-4906-2-git-send-email-manabian@gmail.com>
 <555DD5CB.4040805@ti.com>
Message-ID: <CAGhQ9VxB+Onrzr8MfE5Ocb1-5VoF7FLNwZ14_uUCJS2U9D_Lfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 21 May 2015 at 14:55, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
>
> On Saturday 16 May 2015 10:57 PM, Joachim Eastwood wrote:
>>
>> Add PHY driver for the internal USB OTG PHY found on NXP
>> LPC18xx and LPC43xx devices. This driver takes care of
>> enabling the PHY in CREG (syscon) and setting the required
>> clock frequency.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
<snip>
>> +/* USB OTG PHY register offset and bit in CREG */
>> +#define LPC18XX_CREG_CREG0             0x004
>> +# define LPC18XX_CREG_CREG0_USB0PHY    BIT(5)
>
>
> don't prefer a space between # and define. Not a strong feeling though.

Okey, I'll remove it.

>> +
>> +       phy_provider = devm_of_phy_provider_register(&pdev->dev,
>> +                                                    of_phy_simple_xlate);
>> +       if (IS_ERR(phy_provider))
>> +               return PTR_ERR(phy_provider);
>> +
>> +       return 0;
>
>
> replace it with return PTR_ERR_OR_ZERO(phy_provider);

Okey.


Thanks for the review, Kishon.

I'll send a updated version later today.


regards,
Joachim Eastwood

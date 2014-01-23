From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Jan 2014 22:00:10 +1300
Subject: [PATCH] vt8500: pinctrl: Change devicetree data parsing
In-Reply-To: <CACRpkdaFJphJdf6hyKoYEZ_wXikwRiwzMgtL=hY+3B8WrBnQaw@mail.gmail.com>
References: <1390458701-30238-1-git-send-email-linux@prisktech.co.nz>
 <CACRpkdaFJphJdf6hyKoYEZ_wXikwRiwzMgtL=hY+3B8WrBnQaw@mail.gmail.com>
Message-ID: <52E0DA1A.10108@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/14 21:43, Linus Walleij wrote:
> On Thu, Jan 23, 2014 at 7:31 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>
>> Due to an assumption in the VT8500 pinctrl driver, the value passed
>> from devicetree for 'wm,pull' was not explicitly translated before
>> being passed to pinconf.
>>
>> With changes to 'enum pin_config_param', PIN_CONFIG_BIAS_PULL_(UP/DOWN)
>> no longer map 1-to-1 with the expected values in devicetree.
>>
>> This patch adds a small translation between the devicetree values (0..2)
>> and the enum pin_config_param equivalent values.
>>
>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> Isn't this a regression fix for stable?
>
I wasn't sure how to handle this since it's been a problem since 3.10 
but no one has mentioned it (or patched it).

I assume this is because:
a) pinctrl is only used for I2C in mainline - and there is no mainline 
I2C consumer device drivers for the WonderMedia devices
b) most  users are using the non-mainline kernel which has more support 
(as nasty as some of it is).

Regards
Tony Prisk

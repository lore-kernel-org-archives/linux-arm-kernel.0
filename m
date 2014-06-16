From: trblinux@gmail.com (Tushar Behera)
Date: Mon, 16 Jun 2014 16:49:28 +0530
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>	<1402464739-19044-4-git-send-email-tushar.b@samsung.com>
 <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
Message-ID: <539ED2C0.8030405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2014 10:33 PM, Doug Anderson wrote:
> Tushar,
> 
> On Tue, Jun 10, 2014 at 10:32 PM, Tushar Behera <tushar.b@samsung.com> wrote:
>> Peach-pi board has MAX98090 audio codec connected on HSI2C-7 bus.
> 
> If you want to be a stickler about it, peach-pi actually has a
> max98091.  That requires code changes to the i2c driver, though.
> ...and unfortunately listing two compatible strings for i2c devices is
> broken.  :(
> 
Hi Doug,

You are right. I checked the boot logs, the detected codec type is
MAX98091. Since both these CODECs are supported through a single driver
and the detection of chip is done during runtime, I would suggest we go
ahead with "max98090" compatible string. I will update the commit
message accordingly.

Does that sound okay to you?

> 
>> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts |   31 +++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> index f3af207..76f5966 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -78,9 +78,27 @@
>>                 pinctrl-0 = <&usb301_vbus_en>;
>>                 enable-active-high;
>>         };
>> +
>> +       sound {
>> +               compatible = "google,snow-audio-max98090";
>> +
>> +               samsung,i2s-controller = <&i2s0>;
>> +               samsung,audio-codec = <&max98090>;
>> +       };
>> +};
>> +
>> +&i2s0 {
>> +       status = "okay";
> 
> It would be awfully nice to keep diffs between exynos5420-peach-pit
> and exynos5800-peach-pi clean.  They're 99% the same.  I know this has
> already gotten messed up with DP/HDMI were added, but there's no need
> to make it worse.
> 

If you so desire, I will submit a patch to sort peach-pi device-tree
nodes (w.r.t. peach-pit dts file).

> Could you add these nodes in the same place within the dts they were
> added in exynos5420-peach-pit?
> 

Okay, I will add it after watchdog node.

-- 
Tushar Behera

From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 23:01:06 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <20120530121547.GJ9947@opensource.wolfsonmicro.com>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
Message-ID: <4FC63632.4030504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/12 20:15, Mark Brown wrote:
> On Wed, May 30, 2012 at 07:40:49PM +0800, Lee Jones wrote:
>> On May 30, 2012 6:03 PM, "Mark Brown"<broonie@opensource.wolfsonmicro.com>
>
>>> If we are changing the names then not including the ab8500 bit would
>>> seem more idiomatic - we've already worked out which chip this is by the
>>> time we're looking here.
>
>> No, Linus had the wrong end of the stick. I've just spoken to him in person.
>
>> Those are not the names of the regulators. They're the names of the Device
>> Tree nodes. The regulator names shall remain the same.
>
> Fair enough.  My point about the ab8500_ bit still stands though.

It's a Device Tree thing. I do it so we can easily see which regulator 
is driving which device(s).

I personally think:

	vin-supply = <&db8500_vape_reg>;
	vmmc-supply = <&ab8500_ldo_aux2_reg>;

Tells us so much more and is simpler to decrypt at a glance than 
something like:

	vin-supply = <&vape_reg>;
	vmmc-supply = <&ldo_aux2_reg>;

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

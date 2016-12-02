From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Fri, 2 Dec 2016 15:47:15 +1100
Subject: [PATCH 3/3] ARM: dts: sunxi: enable SDIO Wi-Fi on Orange Pi Zero
In-Reply-To: <da84928a-25a2-1615-1d8e-e6570b1a6323@arm.com>
References: <20161129131922.JFbeipav@smtp2o.mail.yandex.net>
 <da84928a-25a2-1615-1d8e-e6570b1a6323@arm.com>
Message-ID: <1313b989-7591-4598-02b8-250c6943b653@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/16 20:25, Andre Przywara wrote:
> Hi,
> 
> On 29/11/16 10:19, Icenowy Zheng wrote:
>>
>> 2016?11?29? 15:16? Alexey Kardashevskiy <aik@ozlabs.ru>???
>>>
>>>
>>>
>>> On Wed, Nov 23, 2016 at 6:59 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Nov 22, 2016 at 12:24:21AM +0800, Icenowy Zheng wrote:
>>>>> There's a Allwinner's XR819 SDIO Wi-Fi module soldered on the board of
>>>>> Orange Pi Zero, which used a dedicated regulator to power.
>>>>>
>>>>> Add the device tree node of the regulator, the enable gpio (with
>>>>> mmc-pwrseq) and the sdio controller.
>>>>>
>>>>> There's a out-of-tree driver tested to work with this device tree.
>>>
>>>
>>> btw could you please give a pointer where to find a XR819 driver for
>> relatively recent kernel (4.8 may be, just not 3.4)? Thanks.
>>
>> https://github.com/Icenowy/xradio
> 
> I was just curious, so pulled your tree and tried to just compile it. It
> still threw warnings at me for ARM, and even more so for arm64.
> I fixed all of them and put that on my github[1]. Feel free to just pick
> them from there or wait till I manage to clean them up and send you a
> pull request.
> And also just a a test, I quickly put it in drivers/net/wireless/xradio,
> where it compiled fine after registering it with the upper level Kconfig
> and Makefile.
> 
> And while looking at it: This looks like typical AW code, not even
> remotely upstreameable and probably far too complicated. Enabling some
> Kconfig options made it complain about missing functions.
> Has anyone checked if this is close to an existing WiFi chip? That
> wouldn't be a first ;-)
> 
> Cheers,
> Andre.
> 
> [1] https://github.com/apritzel/xradio/commits/quickfixes
> 

I just tried this branch + 4.9.0-rc7 but I am still getting:


[    0.960429] [XRADIO] Driver Label:L34M.01.08.0002
[    0.965233] [XRADIO] Allocated hw_priv @ df6a4dc0
[    3.038180] [SBUS_ERR] sdio probe timeout!
[    3.042288] [XRADIO_ERR] sbus_sdio_init failed


I am missing huge amount of SDIO knowledge. Or the device tree is wrong.
Any idea?


-- 
Alexey

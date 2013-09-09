From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 09 Sep 2013 13:29:44 -0600
Subject: [PATCHv3 1/2] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <FFE100A7-8AD6-4E0D-9F64-120DA3564F89@codeaurora.org>
References: <1378495943-2572-1-git-send-email-rvaswani@codeaurora.org>
 <20130906215051.GA29253@quad.lixom.net> <522E09E6.8040300@codeaurora.org>
 <FFE100A7-8AD6-4E0D-9F64-120DA3564F89@codeaurora.org>
Message-ID: <522E21A8.4060408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2013 01:17 PM, Kumar Gala wrote:
> 
> On Sep 9, 2013, at 12:48 PM, Rohit Vaswani wrote:
> 
>> On 9/6/2013 2:50 PM, Olof Johansson wrote:
>>> Hi,
>>>
>>> Some comments below.
>>>
>>> On Fri, Sep 06, 2013 at 12:32:22PM -0700, Rohit Vaswani wrote:
>>>> This patch adds basic board support for APQ8074 Dragonboard
>>>> <snip>
>>>>  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>>>> -	msm8960-cdp.dtb
>>>> +	msm8960-cdp.dtb \
>>>> +	apq8074-dragonboard.dtb
>>> Please add boards alphabetically.
>> Will do.
>>>
>>>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>>>>  	armada-370-mirabox.dtb \
>>>>  	armada-370-rd.dtb \
>>>> diff --git a/arch/arm/boot/dts/apq8074-dragonboard.dts b/arch/arm/boot/dts/apq8074-dragonboard.dts
>>>> new file mode 100644
>>>> index 0000000..5b7b6a0
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/apq8074-dragonboard.dts
>>> arch/arm/boot/dts/ is getting really crowded. It's been working best if the SoC
>>> family or vendor is used as a prefix to keep things a bit more organized. In
>>> that spirit, prefixing these with msm-<foo> makes sense. Can you please do so?
>>
>> Sure. But the board is called an APQ8074 and we wanted to keep the naming consistent with that.
> 
> If we do this we should use qcom, not msm as the prefix.  Match the device tree vendor prefix.

Hmm. It'd be nice for the filenames to be ${soc}-${board} so that e.g.
U-Boot can easily calculate the DTB filename based on its soc/board
environment variables... Luckily in my case for Tegra, all the Tegra
chip names start with "Tegra", so we already sort all our DTB filenames
together in the directory listing:-)

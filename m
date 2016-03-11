From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 11 Mar 2016 21:46:04 +0300
Subject: [PATCH 0/6] arc_emac: fixes the emac issues oand cleanup emac
 drivers
In-Reply-To: <56E2DAC4.4020105@gmail.com>
References: <1457693731-6966-1-git-send-email-wxt@rock-chips.com>
 <56E2CC39.6050907@cogentembedded.com> <56E2DAC4.4020105@gmail.com>
Message-ID: <56E3126C.7000100@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/11/2016 05:48 PM, Caesar Wang wrote:

[...]

>>> Hi Rob, David:
>>> PATCH[1/6-2/6]: ====>
>>> net: arc_emac: make the rockchip emac document more compatible
>>> net: arc_emac: add phy-reset-* are optional for device tree
>>>
>>> The patches change the rockchip emac document for more compatible and
>>> Add the phy-reset-* property for document.
>>>
>>> This patch adds the following property for arc_emac.
>>>
>>> phy-reset-* include the following:
>>> 1) phy-reset-gpios:
>>> The phy-reset-gpios is an optional property for arc emac device tree boot.
>>> Change the binding document to match the driver code.
>>>
>>> 2) phy-reset-duration:
>>> Different boards may require different phy reset duration. Add property
>>> phy-reset-duration for device tree probe, so that the boards that need
>>> a longer reset duration can specify it in their device tree.
>>>
>>> 3) phy-reset-active-high:
>>> We need that for a custom hardware that needs the reverse reset sequence.
>>
>>    Why not infer this from the "phy-reset-gpios" prop?
>
> See:
> https://patchwork.kernel.org/patch/8564511/
 >
> phy-reset-active-high : If present then the reset sequence using the GPIO
>   specified in the "phy-reset-gpios" property is reversed (H=reset state,
>   L=operation state).

    Referring to your own suggested bindings isn't an answer. If the driver 
that you're copying from here (fec) had a reason to handle the GPIO sense with 
the help of an extra prop (legacy code), it doesn't mean your new driver needs 
to mimic this as well, AFAIU...

> Thanks,
>
> Caesar

MBR, Sergei

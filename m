From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 19 Apr 2018 15:43:37 +0200
Subject: [PATCH 0/2] Allow xhci-plat using a second clock
In-Reply-To: <4d088b87-f3ef-59cd-baae-c82e4f54f639@linux.intel.com> (Mathias
 Nyman's message of "Thu, 19 Apr 2018 08:59:35 +0300")
References: <20180214161620.4401-1-gregory.clement@bootlin.com>
 <87r2ncfvfw.fsf@bootlin.com>
 <4d088b87-f3ef-59cd-baae-c82e4f54f639@linux.intel.com>
Message-ID: <87in8nfh12.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathias,
 
 On jeu., avril 19 2018, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:

> On 18.04.2018 17:20, Gregory CLEMENT wrote:
>> Hi Mathias,
>>     On mer., f?vr. 14 2018, Gregory CLEMENT
>> <gregory.clement@bootlin.com> wrote:
>>
>>> Hello,
>>>
>>> The purpose of this series is to allow xhci-plat using a second
>>> clock. It is needed on the Armada 7K/8K but could be used by other
>>> SoCs.
>>>
>>> The first patch is just a fix found while I was working on this
>>> feature.
>>
>> I've just realized that this series sent 2 months ago was not merged in
>> v4.17. The issue is that now the USB support on the Armada 7K/8K is
>> broken, because the clock support part was already merged.
>>
>> You already had a look on this series one month ago. The issue you had
>> was about getting an approval for the extension of the binding [1]. I
>> pinged Rob about it [2] one month ago but we didn't get any
>> feedback. However, Rob already approved the similar changes I introduced
>> in an other for mv_xor_v2: [3].
>>
>> So would it be possible to apply this series on v4.17-rc ?
>
> Patch 2/2 no longer applies due to clk suspend/resume changes in:
>
> commit d56e57ca030c8b4296944a2ae61ac167bf979c07
>     usb: host: xhci-plat: revert "usb: host: xhci-plat: enable clk in resume timing"
>
> Not sure how that change affects Armada 7K/8K
> Can you rebase and resend the series?

It's done!

About the suspend/resume part it does not affect Armada 7K/8K because we
don't support it yet.

However I am a bit surprised by the commit log because reverting a
common part because of a specific implementation looks wrong. I expect
issues when we will add PM support but we will see that later.

Gregory

>
> -Mathias
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

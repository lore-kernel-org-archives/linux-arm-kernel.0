From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 8 Nov 2012 12:34:54 -0600
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <alpine.DEB.2.00.1211081809470.20703@utopia.booyaka.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BDAF5.1010703@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
 <509BEE6D.9000902@ti.com>
 <alpine.DEB.2.00.1211081754390.20703@utopia.booyaka.com>
 <509BF525.80309@ti.com>
 <alpine.DEB.2.00.1211081809470.20703@utopia.booyaka.com>
Message-ID: <509BFB4E.2090802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/08/2012 12:17 PM, Paul Walmsley wrote:
> On Thu, 8 Nov 2012, Jon Hunter wrote:
> 
>> On 11/08/2012 11:58 AM, Paul Walmsley wrote:
>>> On Thu, 8 Nov 2012, Jon Hunter wrote:
>>>
>>>> Igor was mentioning a h/w scenario where the 32kHz source is not
>>>> present. However, I am not sure which devices support this and is
>>>> applicable too.
>>>
>>> Pretty sure Igor is referring to the AM3517/3505.  This is very poorly 
>>> documented, but can be observed in the AM3517 TRM Rev B (SPRUGR0B) Figure 
>>> 4-23 "PRM Clock Generator" and the AM3517 DM Rev C (SPRS550C) Section 4 
>>> "Clock Specifications".
>>
>> But AFAICT, even in that h/w configuration the internal 32k
>> oscillator will be used
> 
> Just to clarify, there's no internal 32k oscillator used on the 3517/3505; 
> just a divider from the HF clock.

Ah yes I see that now!

>> and so the gptimer will still have a 32k clock source.
> 
> That's a good question and you might want to check with Igor on that one,
> the AM3517 TRM conflicts with the DM as to whether it's available to the 
> GPTIMER or not :-(

Well the external 32k and internal divided down version go through the
same mux and so that seems to imply either they are both available to
the gptimer or neither is.

Cheers
Jon

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 30 Sep 2015 23:25:18 +0300
Subject: [PATCH 30/31] ARM: shmobile: r8a7791: add USB-DMAC device nodes
In-Reply-To: <CAMuHMdVgRzxDUr7SYW2Fx6r4H659gD6whZQMD1tBLKryyO3GxA@mail.gmail.com>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
 <e3e25edc1116ebf44b1813aff03b02b7737d41ca.1431565427.git.horms+renesas@verge.net.au>
 <560B11FF.3010305@cogentembedded.com>
 <CAMuHMdWuAz1gGbFzgjn7mM+Q6fgqjSCG-+8VtZ+4AMJG72mbtg@mail.gmail.com>
 <560C41C7.70200@cogentembedded.com>
 <CAMuHMdVgRzxDUr7SYW2Fx6r4H659gD6whZQMD1tBLKryyO3GxA@mail.gmail.com>
Message-ID: <560C452E.2010301@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2015 11:13 PM, Geert Uytterhoeven wrote:

>>>>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>>>
>>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>>> ---
>>>>>     arch/arm/boot/dts/r8a7791.dtsi | 22 ++++++++++++++++++++++
>>>>>     1 file changed, 22 insertions(+)
>>
>>>>      When the USB-DMAC driver is enabled, this causes kernel oops on at
>>>> least
>>>> the R8A7791 Henninger/Porter boards (haven't checked the others yet) with
>>>> renesas-devel-20150928-v4.3-rc3 and even earlier tag. The oops can only
>>>> be
>>>> seen with the earlyprintk=serial kernel parameter, otherwise the kernel
>>>> just
>>>> hangs with a blank console.
>>>
>>> My current kernel on r8a7791/koelsch has CONFIG_RENESAS_USB_DMAC=y and
>>> boots
>>> fine.
>>>
>>> renesas-devel-20150928-v4.3-rc3 with shmobile_defconfig +
>>> CONFIG_RENESAS_USB_DMAC=y also boots fine.
>>
>>     Indeed, I was able to boot it all the way on Henninger.
>>
>>> Do I need to enable/disable config options to trigger this?
>>
>>     It appears so. I just don't know what -- the diff between my .config and
>> shmobile_defconfig is 150+ hunks. :-(

   OK, my shot in the dark proved helpful: it's the kernel preemption mode -- 
shmobile_defconfig has CONFIG_PREEMPT_NONE, my .config has CONFIG_PREEMPT!

> Can you please send me your .config by private email?

   OK.

> Thanks!
>
> Gr{oetje,eeting}s,

MBR, Sergei

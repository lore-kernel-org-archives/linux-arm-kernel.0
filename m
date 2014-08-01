From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 1 Aug 2014 20:02:16 +0800
Subject: [PATCH v15 07/12] ARM: dts: append hip04 dts
In-Reply-To: <CAOesGMg4qtuJoDzYHMEDesOSqySygM8pxgrxtm1Bz09SuKOiwQ@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-8-git-send-email-haojian.zhuang@linaro.org>
 <20140728180609.GE2576@leverpostej>
 <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
 <20140729035321.GA8430@quad.lixom.net>
 <CAOesGMg4qtuJoDzYHMEDesOSqySygM8pxgrxtm1Bz09SuKOiwQ@mail.gmail.com>
Message-ID: <CAD6h2NQ96kUNfD1-rw1cHL1FaFR-n4tuRZC8ASeBTuJTfnrwcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2014 12:00, Olof Johansson <olof@lixom.net> wrote:
>>> >> +                       reg = <0x3e00000 0x00100000>;
>>> >> +                       relocation-entry = <0xe0000100>;
>>> >> +                       relocation-size = <0x1000>;
>>> >> +                       bootwrapper-phys = <0x10c00000>;
>>> >> +                       bootwrapper-size = <0x10000>;
>>> >> +                       bootwrapper-magic = <0xa5a5a5a5>;
>>> >
>>> > Are these absolute addresses, or translated per ranges above?
>>> >
>>> > Why are they related to the system controller?
>>> >
>>>
>>> I need these parameters. But I can't find a better place.
>>
>> Again, what is the boot wrapper in this case? And what do you need them for?
>
> Ok, looking at patch 3/12, it seems that the "bootwrapper" base
> address is used to specify where the CPU goes when released by the
> system controller.
>
> Isn't there an address that can be written in the system controller
> that specifies this base address, such that you can just handle this
> dynamically at runtime? It seems really, really odd that the platform
> will expect this one page in the middle of ram to just be untouched
> otherwise.
>

I'll move these parameters from DTS file to command line. Then I can
reserve these memory when I parse the command line.

Regards
Haojian

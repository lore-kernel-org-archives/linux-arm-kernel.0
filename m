From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 1 Oct 2016 15:05:01 +0530
Subject: [PATCH 4/6] ARM: dts: da850-lcdk: add support for 1024x768
 resolution
In-Reply-To: <CAMpxmJX25Yx0Rget4bOUf+t2qn01bpbNGBwwVFfomK1h_2Oydg@mail.gmail.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-5-git-send-email-bgolaszewski@baylibre.com>
 <20160929185805.q2pdihajikgzo4lm@gobelin>
 <CAMpxmJVA+p1st7HzwoOJftArqpY-wUQb8WKbQFAEWnBOysxF6w@mail.gmail.com>
 <20160930124942.ul737vxmdmkxqdre@gobelin>
 <CAMpxmJX25Yx0Rget4bOUf+t2qn01bpbNGBwwVFfomK1h_2Oydg@mail.gmail.com>
Message-ID: <c4de4240-62d6-754f-c0d0-d83ecce59485@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2016 07:18 PM, Bartosz Golaszewski wrote:
> 2016-09-30 14:49 GMT+02:00 Karl Beldan <karl.beldan@gmail.com>:
>> On Fri, Sep 30, 2016 at 11:37:57AM +0200, Bartosz Golaszewski wrote:
>>> 2016-09-29 20:58 GMT+02:00 Karl Beldan <karl.beldan@gmail.com>:
>>>> Hi,
>>>>
>>>> On Thu, Sep 29, 2016 at 06:31:53PM +0200, Bartosz Golaszewski wrote:
>>>>> Add svga timings for 1024x768 resolution to the da850-lcdk
>>>>> device tree.
>>>>>
>>>>
>>>
>>> [snip]
>>>
>>>>
>>>> Why do you also call 1024x768 svga ?
>>>>
>>>
>>> Thanks, should have been xga. will fix in v2.
>>>
>>>> I don't think the LCDK can cope with this resolution at this frequency
>>>> (in terms of mem bandwidth), at least that's what I observed back in
>>>> August. If confirmed I think it is worth mentioning in the log at least,
>>>> but then I doubt adding this config would be useful.
>>>>
>>>
>>> Thanks for the heads up. How would that manifest itself? This seems to
>>> work fine for me - I'm not getting any warnings on a simple system -
>>> maybe if I added some additional memory load it would complain.
>>>
>>
>> A mere dmesg > /dev/tty0 (or repeatedly cat-ting a file to /dev/tty0)
>> should suffice to make the issue visible and trigger FIFO underflows.
>>
> 
> Thanks, this is correct unfortunately.

The OMAP-L138 datasheet documents 37.5 MHz as the maximum pixel clock
possible on the device. Looks like you need 72MHz pixel clock for
1024x768 which is definitely out of spec.

Thanks,
Sekhar

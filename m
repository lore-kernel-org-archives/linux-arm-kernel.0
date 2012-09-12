From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 12 Sep 2012 23:25:45 +0530
Subject: [PATCH 13/16] ARM: omap: move platform_data definitions
In-Reply-To: <201209111704.16708.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com>
 <504F6249.2090501@ti.com> <201209111704.16708.arnd@arndb.de>
Message-ID: <5050CCA1.8090601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/11/2012 10:34 PM, Arnd Bergmann wrote:
> On Tuesday 11 September 2012, Vaibhav Hiremath wrote:
>> On 9/11/2012 7:54 PM, Shilimkar, Santosh wrote:
>>> On Tue, Sep 11, 2012 at 7:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Tuesday 11 September 2012, Shilimkar, Santosh wrote:
>>>>> Just curious to know how you came with some of the above header names ?
>>>>>
>>>>> plat/mcbsp ---> dsp-mcbsp.h
>>>>> There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
>>>>> better name.
>>>>
>>>> This one was a mistake on my side, as Tony and  Peter already pointed out.
>>>> How about asoc-mcbsp.h or asoc-omap-mcbsp.h?
>>>>
>>> After re-reading the cover-letter and your below response,
>>> 'asoc-omap-mcbsp.h' seems to be fine.
>>>
>>
>> Note that mcbsp is also applicable to Davinci family of devices.
> 
> asoc-ti-mcbsp.h then?

DaVinci has a McBSP, but it is not the same as OMAP McBSP. The driver is
different (sound/soc/davinci/davinci-i2s.c vs sound/soc/omap/mcbsp.c)
and there as IP differences as well. It is better to keep the name as
asoc-omap-mcbsp.h for clarity.

Thanks,
Sekhar

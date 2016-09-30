From: karl.beldan@gmail.com (Karl Beldan)
Date: Fri, 30 Sep 2016 09:39:17 +0000
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <CAMpxmJVQwQPa6FK+UGe1f7n5LdWUQyN9g+hO3OHB7PFqWrNY=w@mail.gmail.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <20160929190736.vgd3xylzm2nh32l4@gobelin>
 <CAMpxmJVQwQPa6FK+UGe1f7n5LdWUQyN9g+hO3OHB7PFqWrNY=w@mail.gmail.com>
Message-ID: <CACYmx9Or8ZUNvowx3TdsW7=uXB-OFcje1A8fk704n+ZJPQ943A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 9:31 AM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> 2016-09-29 21:07 GMT+02:00 Karl Beldan <karl.beldan@gmail.com>:
>> Hi,
>>
>> On Thu, Sep 29, 2016 at 06:31:55PM +0200, Bartosz Golaszewski wrote:
>>> Default memory settings of da850 do not meet the throughput/latency
>>> requirements of tilcdc. This results in the image displayed being
>>> incorrect and the following warning being displayed by the LCDC
>>> drm driver:
>>>
>>>   tilcdc da8xx_lcdc.0: tilcdc_crtc_irq(0x00000020): FIFO underfow
>>>
>>> Reconfigure the LCDC priority to the highest. This is a workaround
>>> for the da850-lcdk board which has the LCD controller enabled in
>>> the device tree, but a long-term, system-wide fix is needed for
>>> all davinci boards.
>>>
>>> This patch has been modified for mainline linux. It comes from a
>>> downstream TI release for da850[1].
>>>
>>> Original author: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
>>>
>>> [1] http://arago-project.org/git/projects/linux-davinci.git?p=projects/linux-davinci.git;a=commitdiff;h=b9bd39a34cc02c3ba2fc15539a2f0bc2b68d25da;hp=6f6c795faa6366a4ebc1037a0235edba6018a991
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>
>> FWIW, the quirks could be applied conditionnally depending on the lcdc
>> node presence in the DT, a bit like:
>> https://github.com/kbeldan/linux/commit/cf15572ffef8e8a0d8110b3f6b29bd401d0538be
>> https://github.com/kbeldan/linux/commit/07e4fff9958bc1625a96791dce284c163fbe9c43
>>
>>
>> Regards,
>> Karl
>
> Hi Karl,
>
> I decided to post the simplest possible way of this to get the lcdc
> working upstream. In parallel I'm working on a system-wide way of
> applying such quirks not only limited to device tree nodes' presence.

Ok, that'd be a good thing, apparently people have been looking
to do such a thing for the am335x as well.

Regards,
Karl

> Thanks for the info!
>
> Best regards,
> Bartosz Golaszewski

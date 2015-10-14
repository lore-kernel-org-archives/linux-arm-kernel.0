From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 14 Oct 2015 10:52:55 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <561DB290.5070903@samsung.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
 <561C4CEE.3050905@samsung.com>
 <CANAwSgRJ+5O-x61K9E_AxTZWQy3jJrKF5MiLtWRdUU29CCfa-Q@mail.gmail.com>
 <561C7DF1.6000609@samsung.com>
 <CANAwSgRBzFqHB98wSQnQu-ggGqRT2H6wC415wULXVhPg0uw_3A@mail.gmail.com>
 <561D9ACE.6050103@samsung.com>
 <CAGOxZ51uPkdGmCAs2Tc8_=YvkORJKdivN47vo1ZxkGQ-MY=-oQ@mail.gmail.com>
 <561DACC6.9040209@samsung.com> <561DB290.5070903@samsung.com>
Message-ID: <561DB577.8080808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.10.2015 10:40, Jaehoon Chung wrote:
> On 10/14/2015 10:15 AM, Krzysztof Kozlowski wrote:
>> On 14.10.2015 10:06, Alim Akhtar wrote:
>>> +Doug
>>> Hello,
>>> AFAIR, dw_mmc host controller does support UHS-I [1], specially SDR50
>>> and SDR104 modes.
>>>
>>> [1]: http://www.spinics.net/lists/linux-mmc/msg28186.html
>>>
>>> What I remember is, one need to set "broken-cd" property also in order
>>> to make it work because of the vqmmc and vmmc connection on board. I
>>> didn't find the link right now, but you can search on the web, there
>>> was a long discussion about handling this.
>>> Have not checked it recently, so not sure if this got broken somehow.
>>>
>>
>> Please, don't top post.
>>
>> I am not a SD/MMC specialist (I do not feel enough confident in its
>> internals) but the datasheet for 5422 does not mention UHS. However it
>> mentions "High Speed DDR Mode with 200 MHz clock rate (HS400)". This
>> does not look like UHS...
> 
> You're right. It's not UHS mode. it mentions eMMC's HS400 mode.
> UHS and HS400 are difference mode.
> 
> eMMC mode are supported 
> 
>> https://www.sdcard.org/developers/overview/bus_speed/
>> This of course is not a definite proof that 5422 does not support UHS. I
>> am just saying that I couldn't find any information that *it does*.
> 
> Well, I think you want to know whether it supported or not.
> Then you can find the information at User manual.
> In mobile storage part of User manual, it described the overview.
> Mobile storage host supports these specification:
> - Secure Digital memory (SD memory version 3.0)
> - Secure Digital I/O SDIO (SDIO version 3.0)
> - etc...
> 
> SD3.0 is supported UHS-I mode. 
> If user manual of exynos5422 is mentioned this specification, it should be supported UHS-I mode.

Thanks! Indeed datasheet mentions that supported SD and SDIO is version
3.0 (not 3.01... which seems irrelevant because 3.0 introduced UHS-I,
right?).

Best regards,
Krzysztof

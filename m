From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 07 Sep 2015 16:24:53 +0900
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable DW USB2 support and
 rockchip phy
In-Reply-To: <1441609832.8778.4.camel@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-5-git-send-email-sjoerd.simons@collabora.co.uk>
 <55ECD40F.8020001@samsung.com> <1441609832.8778.4.camel@collabora.co.uk>
Message-ID: <55ED3BC5.8050603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.09.2015 16:10, Sjoerd Simons wrote:
> Hey Krzysztof,
> 
> On Mon, 2015-09-07 at 09:02 +0900, Krzysztof Kozlowski wrote:
>> On 07.09.2015 05:16, Sjoerd Simons wrote:
>>> The DesignWare HS OTG USB 2.0 is used in various SoC families among
>>> wich
>>> the various rockchip SoCs, enable the driver and the PHY glue for
>>> rockchip
>> +Cc Marek and Kukjin,
>>
>> This would conflict with Marek's:
>> [PATCH v2] ARM: multi_v7_defconfig: Enable DWC2 USB driver and USB
>> ethernet gadget
>> http://www.spinics.net/lists/linux-samsung-soc/msg46743.html
>>
>> Probably your series and Marek's change should go together to the
>> same
>> tree. How about rebasing your work on top of it?
> 
> Thanks for the pointer! I'm entirely happy to rebase on Mareks patch or
> this one dropped for now until Mareks patch lands. 
> 
> These patches were based on current linux-next, so i guess Mareks pathc
> didn't land just yet? Tbh, i don't really know what tries multi_v7
> tends to go through (especially for non-platform specific changes)

It was too late for Marek's patch to go for v4.3 merge window, so I
applied it but not pushed to my for-next branch. AFAIU, Stephen does not
want v4.4 material during merge window because of mangling with statistics.


If you want to rebase (or cherry-pick), you can find Marek's patch here:
branch: defconfig-for-next
repo: git://github.com/krzk/linux.git

However this *branch will be rebased on v4.3-rc1* (because this is
material for v4.4). After v4.3-rc1 I can prepare a tag for other
interested parties.


As for multi_v7_defconfig policy, I got impression from the
Arnd/Olof/Kevin comments on LKML, that platform specific changes should
go through platform tree. However this is multi-platform change so maybe
we can push both patches through arm-soc.


Arnd, Olof, Kevin (BTW, you missed to CC him),

How do you wish to handle this case (USB_DWC2 and two patches: Marek's
and Sjoerd's)?

Best regards,
Krzysztof

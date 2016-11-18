From: rsahu@apm.com (Rameshwar Sahu)
Date: Fri, 18 Nov 2016 16:19:49 +0530
Subject: arasan,sdhci.txt "compatibility" DT binding
In-Reply-To: <582ED9E0.5090506@free.fr>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com>
 <20160203152104.GP4215@xsjsorenbubuntu> <56B21DDB.6050708@free.fr>
 <582ED9E0.5090506@free.fr>
Message-ID: <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mason,


Suman/APM added "arasan,sdhci-4.9a" in 308f3f8d8112
@Suman, @Rameshwar: what specific IP block does your SoC embed?
What does 4.9a refer to? The documentation revision number?

We have Arasan SD3.0/ SDIO3.0/ eMMC4.41 AHB Host Controller IP
embedded in our SoC and 4.9a is documentation revision number which
was given by arasan.
FYI this documentation date was May, 2012.

Thanks,
Ram

On Fri, Nov 18, 2016 at 4:07 PM, Mason <slash.tmp@free.fr> wrote:
> On 03/02/2016 16:33, Mason wrote:
>> On 03/02/2016 16:21, S?ren Brinkmann wrote:
>>> On Wed, 2016-02-03 at 10:58:24 +0100, Michal Simek wrote:
>>>> On 3.2.2016 09:31, Mason wrote:
>>>>> On 03/02/2016 08:20, Michal Simek wrote:
>>>>>
>>>>>> On 3.2.2016 03:33, Shawn Lin wrote:
>>>>>>> + Michal, S?ren Brinkmann
>>>>>>>
>>>>>>> On 2016/2/2 17:49, Mason wrote:
>>>>>>>> Hello everyone,
>>>>>>>>
>>>>>>>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:
>>>>>>>>
>>>>>>>> Required Properties:
>>>>>>>>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>>>>>>>>                  'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>>>>>>>
>>>>>>>> What do 8.9a, 4.9a, and 5.1 refer to?
>>>>>>>>
>>>>>>>
>>>>>>> Good question.
>>>>>>>
>>>>>>> Michal told me that 8.9a and 4.9a came from Xilinx
>>>>>>> databook which define their available arasan controller to be version
>>>>>>> 4.9a and 8.9a.
>>>>>>
>>>>>> Our version is coming from here.
>>>>>> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
>>>>>> page 28
>>>>>>
>>>>>> Datasheets from 2012 and 2010 doesn't look too recent and I expect that
>>>>>> Arasan did a lot of work from that time that's why I am not surprised
>>>>>> that you are not able to see that versions.
>>>>>
>>>>> Hello Michal,
>>>>>
>>>>> I'm even more confused.
>>>>>
>>>>> Arasan's 2010-02-19 data sheet is titled
>>>>> SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller
>>>>>
>>>>> Page 28 of the Xilinx data sheet mentions
>>>>> SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller
>>>>> Version 8.9A_apr02nd_2010
>>>>>
>>>>> It does not make sense that Arasan would support SD3.0 in February,
>>>>> then go back to SD 2.0 in April.
>>>>>
>>>>> I do note eMMC4.4 vs MMC3.31 => perhaps these are two *different*
>>>>> IP blocks?
>>>>>
>>>>> Do your data sheets come with revision history?
>>>>
>>>> I don't have datasheet for this IP in my hand that's why I can't check it.
>>>> But I can't see any problem with it. Our zynq SoC supports SD2.0 and it
>>>> was requirement at that time. Bugs can happen. Arasan fixed it and
>>>> create new version.
>>>> At the same time can have 3.0 versions but vendor is just decide not to
>>>> use it for whatever reason.
>>>>
>>>> That's why timing of features and versions can upgrade any time and
>>>> unfortunately bugs happen.
>>>
>>> We have several Arasan data sheets here. The document names are:
>>> "SD2.0 / SDIO2.0 / MMC3.31 AHB Userguide" and the revisions are 9.2a,
>>> 4.4a and 5.4a. I have the feeling that the document revisions have
>>> been mistaken as the IP revision. I cannot find any other indicator
>>> for the IP revision though. Does the IP have a way to discover its
>>> revision?
>>
>> To summarize, it looks to me like
>> 4.9a and 8.9a are documentation revision numbers for this IP:
>> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
>>
>> and 5.1 seems to be the eMMC standard, so one of these IP:
>> http://arasan.com/products/emmc51/sd3-emmc-5-1-host/
>> http://arasan.com/products/emmc51/emmc-5-1-sd-4-1-host/
>>
>> Whereas my board is using still another IP:
>> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
>>
>>
>> If that is correct, then I should be able to use the 8.9a
>> compatible string, and perhaps my hardware will work in
>> slightly degraded performance mode, from not using the
>> newest protocol gizmos available.
>
> Resurrecting this thread after a chat with Michal on IRC.
>
> The driver now supports a few more compatible strings.
> Tracing the history...
>
> Soren/Xilinx defined "arasan,sdhci-8.9a" in e3ec3a3d11ad
> They have the "SD2.0/SDIO2.0/MMC3.31 AHB Host Controller" version
> (8.9a might be a document revision number, dated 2010-04-02)
>
> Suman/APM added "arasan,sdhci-4.9a" in 308f3f8d8112
> @Suman, @Rameshwar: what specific IP block does your SoC embed?
> What does 4.9a refer to? The documentation revision number?
>
> Shawn/Rockchip added "arasan,sdhci-5.1" in da795ec26e25
> This seems to be for an *actual* eMMC 5.1 version
> (instead of a documentation version) as mentioned in
> the commit message.
>
> Douglas added "rockchip,rk3399-sdhci-5.1"
> and made several other improvements.
>
> I have reached out to Arasan support. Hopefully they can also
> help clear up the confusion, assuming they care about the
> Linux driver.
>
> Regards.
>

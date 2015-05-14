From: zhengxing@rock-chips.com (zhengxing)
Date: Thu, 14 May 2015 10:22:18 +0800
Subject: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
In-Reply-To: <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk> <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
Message-ID: <555406DA.8040709@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?14? 07:11, Dylan Reid wrote:
> On Wed, May 13, 2015 at 10:21 AM, Dylan Reid<dgreid@chromium.org>  wrote:
>> On Wed, May 13, 2015 at 9:42 AM, Mark Brown<broonie@kernel.org>  wrote:
>>> On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
>>>> On 2015?05?13? 03:22, Mark Brown wrote:
>>>>> Is it not possible to extend simple card to handle your use cases?
>>>>> Given the very generic naming and the fact that things like jack
>>>>> detection and so on should depend on the CODEC and board usually rather
>>>>> than on the SoC it doesn't sound like this is Rockchip specific.
>>>>> This also looks like you're reimplementing some device model enumeration
>>>>> stuff which probably shouldn't be happening but let's understand the
>>>>> problem you're trying to solve here before going too far into the code.
>>>> Because we are trying to bring rt5650 in the project, so we intend to
>>>> describe supported codecs with DTS via only a rockchip machine driver file,
>>>> others remain pre-implement(like max98090 / rt5645 that vendor machine
>>>> driver).
>>> I don't undertand what you're saying here, sorry - why is this not just
>>> a case of writing multiple machine drivers?
>> I don't understand this either.  I'd think the best solution is
>> simple-card, configured through DTS for each device.

Hi Mark, Dylan,
I tried to use simple-card and had some trouble that jack detection. So 
my idea is simply:
                                                   /-- rockchip_max98090 
(to configure max98090, and no need to via DTS)
    rockchip_machine_driver  |-- rockchip_rt5645 (to configure 
rt5650/rt5645, and no need to via DTS)
(supported codecs via DTS)   \-- rockchip_(maybe other codecs)

It is right that it is base on original rockchip_max98090, but the old 
rockchip_max98090 used DTS.

I tried to explain my ideas. Your kind suggestions will be highly 
appreciated.

Thanks.

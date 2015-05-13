From: zhengxing@rock-chips.com (zhengxing)
Date: Wed, 13 May 2015 21:23:01 +0800
Subject: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
In-Reply-To: <20150512192215.GZ3066@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
Message-ID: <55535035.5070608@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?13? 03:22, Mark Brown wrote:
> On Tue, May 12, 2015 at 05:26:34PM +0800, Xing Zheng wrote:
>> From: zhengxing<zhengxing@rock-chips.com>
>>
>> In most cases, we maybe use simple-card as generic machine driver
>> on next kernel, but there are some issue that jack detection and
>> widgets extandable on simple-card.
>>
>> Own machine drvier can select one valid codec from supported codecs,
>> and add needful function from dts on rockchip platform.
> Is it not possible to extend simple card to handle your use cases?
> Given the very generic naming and the fact that things like jack
> detection and so on should depend on the CODEC and board usually rather
> than on the SoC it doesn't sound like this is Rockchip specific.
>
> This also looks like you're reimplementing some device model enumeration
> stuff which probably shouldn't be happening but let's understand the
> problem you're trying to solve here before going too far into the code.
Dear Mark,
Thanks for your reply.

Because we are trying to bring rt5650 in the project, so we intend to 
describe supported codecs with DTS via only a rockchip machine driver file,
others remain pre-implement(like max98090 / rt5645 that vendor machine 
driver).
I communicated with Dylan, and he told me that the jack detection is an 
issue in the simple-card, and suggested we are better to send them at 
present.

Thanks.

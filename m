From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 14 Sep 2014 22:53:28 +0400
Subject: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of
 rockchip i2s controller
In-Reply-To: <5414FD6E.2050006@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
 <5414AFA6.9060904@cogentembedded.com> <5414FD6E.2050006@rock-chips.com>
Message-ID: <5415E428.10101@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/14/2014 06:29 AM, Jianqun wrote:

>>> Reference rockchip I2S controller TRM, modify some registers' property
>>> I2S_FIFOLR: read / write, but not volatile, not precious
>>> I2S_INTSR: read / write
>>> I2S_CLR: volatile, register value will be cleared by read

>>> Test on RK3288 with max98090.

>>> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>>> ---
>>>    sound/soc/rockchip/rockchip_i2s.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)

>>> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
>>> index 1b9b404..6595383 100644
>>> --- a/sound/soc/rockchip/rockchip_i2s.c
>>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>> [...]
>>> @@ -385,8 +387,6 @@ static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>>    static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
>>>    {
>>>        switch (reg) {
>>> -    case I2S_FIFOLR:
>>> -        return true;
>>>        default:
>>>            return false;
>>>        }

>>     Shouldn't this be folded into simple *return* false now?

> That is more reasonable, thank you.

    Moreover, this function may be completely eliminated.

WBR, Sergei

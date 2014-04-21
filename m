From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Apr 2014 14:03:49 -0600
Subject: [PATCH 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <CAD=FV=W8=SLxF=goYm9p3Dr0ZQYy9FzN0hbE+MwWFYGarZB9tw@mail.gmail.com>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>	<1397757570-19750-8-git-send-email-dianders@chromium.org>	<535560E9.5040108@wwwdotorg.org>
 <CAD=FV=W8=SLxF=goYm9p3Dr0ZQYy9FzN0hbE+MwWFYGarZB9tw@mail.gmail.com>
Message-ID: <535579A5.2060603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2014 01:35 PM, Doug Anderson wrote:
> Stephen,
> 
> On Mon, Apr 21, 2014 at 11:18 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/17/2014 11:59 AM, Doug Anderson wrote:
>>> This adds the EC i2c tunnel (and devices under it) to the
>>> tegra124-venice2 device tree.

>>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
>>
>>>       aliases {
>>> +             i2c20 = "/spi at 0,7000d400/cros-ec at 0/i2c-tunnel";
>>
>> Is that needed? I'd prefer not to add it unless there's a specific
>> reason. I don't think I2C buses need specific names, do they?
> 
> It is not strictly needed, but from a usability standpoint it is
> terribly helpful.  It serves to make it obvious to someone looking at
> the device that it's _not_ an i2c bus associated with the main SoC.
> If you don't include a number I believe that the i2c core will pick
> the first available number.
> 
> It seems worth it to save a few people a few hours of head scratching.
> 
> ...but this is your dts and if you think it's a terrible idea then
> I'll remove it.  It looks to be less critical on tegra than it is on
> exynos (which has ~9 i2c busses, they are numbered in the user manual,
> and if you have one set to "disable" in the dts then the tunnel will
> end up getting a very confusing number).

My opinion is that the in-kernel I2C bus numbering is an entirely
unrelated numbering space to the HW controller numbering space precisely
because of issues like that. DT aliases are more useful for user-visible
port numbering (e.g. HDMI 0, 1 connectors on a case) than purely
internal details like this. So, I would leave it out.

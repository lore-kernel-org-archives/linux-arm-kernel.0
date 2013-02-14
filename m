From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 21:42:39 -0700
Subject: [PATCH v1 2/4] ARM: dts: Add i2c-arbitrator bus for
 exynos5250-snow
In-Reply-To: <CAD=FV=XLMYAyW7W3PtoUmROOgttuypHKNWtrcALw3t6jdyEDPw@mail.gmail.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <1360778532-7480-2-git-send-email-dianders@chromium.org>
 <511BFFD2.8090102@wwwdotorg.org>
 <CAD=FV=XLMYAyW7W3PtoUmROOgttuypHKNWtrcALw3t6jdyEDPw@mail.gmail.com>
Message-ID: <511C6B3F.3030206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2013 05:38 PM, Doug Anderson wrote:
> Stephen,
> 
> 
> On Wed, Feb 13, 2013 at 1:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 02/13/2013 11:02 AM, Doug Anderson wrote:
>>> We need to use the i2c-arbitrator to talk to any of the devices on i2c
>>> bus 4 on exynos5250-snow so that we don't confuse the embedded
>>> controller (EC).  Add the i2c-arbitrator to the device tree.  As we
>>> add future devices (keyboard, sbs, tps65090) we'll add them on top of
>>> this.
>>>
>>> The arbitrated bus is numbered 104 simply as a convenience to make it
>>> easier for people poking around to guess that it might have something
>>> to do with the physical bus 4.
>>>
>>> The addition is split between the cros5250-common and the snow device
>>> tree file since not all cros5250-class devices use arbitration.

>>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>>
>>> +     i2c-arbitrator {
>>> +             compatible = "i2c-arbitrator";
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>
>>> +             /* Use ID 104 as a hint that we're on physical bus 4 */
>>> +             i2c_104: i2c at 0 {
>>
>> Does something use that hint? It sounds a little odd.
> 
> The i2c bus numbering patches will end up creating "/dev/i2c-104".

Oh sorry, I see this is just the alias doing it's job. I'd misread that
as the reg value being 104 and driving the bus ID.

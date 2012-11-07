From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 7 Nov 2012 09:49:30 +0530
Subject: [PATCH RFC] ARM: EXYNOS5: Setup legacy i2c controller interrupts
 on SMDK5250
In-Reply-To: <CAJuYYwQzBU0=L_dFLj8=hSPremnOKPocF7oS68X1tCBDXuKLYw@mail.gmail.com>
References: <1352182726-29221-1-git-send-email-a.kesavan@samsung.com>
 <CAJuYYwSka_-w+_hJQivu6M2tUDtD-9zH-4YtLeSoTwPODODQMw@mail.gmail.com>
 <CAM4voaki_t=AMNZ4g8-aWTCATNYQTSBSjxiH0jPX2dddMoj+jw@mail.gmail.com>
 <CAJuYYwQzBU0=L_dFLj8=hSPremnOKPocF7oS68X1tCBDXuKLYw@mail.gmail.com>
Message-ID: <CAM4voany04h5Gg_jsVpQKTs+q5RN-V1SUBMoDkg0d2m=NZ878A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the clarification.
On Wed, Nov 7, 2012 at 9:35 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> On 7 November 2012 09:12, Abhilash Kesavan <kesavan.abhilash@gmail.com> wrote:
>> Hi Thomas,
>>
>> Thanks for the suggestions.
>>
>> On Tue, Nov 6, 2012 at 1:45 PM, Thomas Abraham
>> <thomas.abraham@linaro.org> wrote:
>>> On 6 November 2012 11:48, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>>>> On Exynos5 we have a new high-speed i2c controller. The interrupt
>>>> sources for the legacy and new controller are muxed and are controlled
>>>> via the SYSCON I2C_CFG register.
>>>> At reset the interrupt source is configured for the high-speed controller,
>>>> to continue using the old i2c controller we need to modify the I2C_CFG
>>>> register.
>>>
>>> If the high-speed i2c controllers are not used, can this configuration
>>> be moved into the bootloader?
>>>
>>> The other option could be, in the exynos5250_dt_machine_init()
>>> function, first check if the platform is compatible with
>>> "samsung,exynos5250" and if so search for a high-speed i2c controller
>>> compatible node. If a high-speed controller node is found and if that
>>> node is not disabled, then do not change the reset value of I2C_CFG
>>> register.
>>>
>> I'd like to try this out. Do we have to a scenario where both hs-i2c and legacy
>> i2c nodes are added to the dts file without disabling either of them or is it
>> expected that one of these will always be disabled in the board-specific
>> dts file (as only one can work at a time) ?
>
> I would expect only one of the two types of i2c controller to be
> enabled in the board dts file. I don't think there will be use case
> where we have to switch between low-speed and high-speed controllers
> at runtime.
>
> And, since there are four interrupt configuration bits in I2C_CFG,
> alias id would be required to determine which bit in the I2C_CFG
> register has be setup.
>
> Thanks,
> Thomas.

From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 13:57:19 +0530
Subject: [PATCH v4 5/5] ARM: dts: enable hdmi for exynos5800 based
 peach-pi board
In-Reply-To: <5373CAB7.3040002@gmail.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-6-git-send-email-rahul.sharma@samsung.com>
 <5373CA74.8080500@gmail.com> <5373CAB7.3040002@gmail.com>
Message-ID: <CAPdUM4PxYqrt1xaZJ6vw5GXk8wFzRGG=ayscvs0x=n7=deJZKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2014 01:27, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>
> On 14.05.2014 21:56, Tomasz Figa wrote:
>> Hi Rahul,
>>
>> On 14.05.2014 04:46, Rahul Sharma wrote:
>>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>>
>>> Enable hdmi for peach-pi board.
>>>
>>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5800-peach-pi.dts |   19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> index 742655b..2a6f23b8 100644
>>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> @@ -134,6 +134,25 @@
>>>      };
>>>  };
>>>
>>> +&i2c_2 {
>>> +    status = "okay";
>>> +    samsung,i2c-sda-delay = <100>;
>>> +    samsung,i2c-max-bus-freq = <66000>;
>>> +    samsung,i2c-slave-addr = <0x50>;
>>> +
>>> +    hdmiddc at 50 {
>>> +            reg = <0x50>;
>>> +    };
>
> Aha, also with the new Exynos HDMI bindings, I don't think the DDC
> device node is necessary any longer.

Yea it is not necessary now. I added it to list the i2c devices
under controller node. Just for completion.

>
> Best regards,
> Tomasz

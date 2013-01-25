From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 25 Jan 2013 12:03:26 +0530
Subject: [PATCH V2] ARM: DTS: exynos5250-arndale: Add initial board support
 file
In-Reply-To: <CAGOxZ50LiupEj0s2scMYZQiCA2V4GNT6zoUVYR7TMyEsX3sf-Q@mail.gmail.com>
References: <1359090411-26159-1-git-send-email-tushar.behera@linaro.org>
 <CAGOxZ50LiupEj0s2scMYZQiCA2V4GNT6zoUVYR7TMyEsX3sf-Q@mail.gmail.com>
Message-ID: <51022736.5030007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2013 10:59 AM, Alim Akhtar wrote:

[ ... ]

>> +
>> +       dwmmc_2: dwmmc2 at 12220000 {
>> +               num-slots = <1>;
>> +               supports-highspeed;
>> +               fifo-depth = <0x80>;
>> +               card-detect-delay = <200>;
>> +               samsung,dw-mshc-ciu-div = <3>;
>> +               samsung,dw-mshc-sdr-timing = <2 3>;
>> +               samsung,dw-mshc-ddr-timing = <1 2>;
>> +
>> +               slot at 0 {
>> +                       reg = <0>;
>> +                       bus-width = <4>;
>> +                       samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
>> +                       gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
>> +                               <&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
>> +                               <&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
>> +                               <&gpc4 3 3 3 3>, <&gpc4 4 3 3 3>,
>> +                               <&gpc4 5 3 3 3>, <&gpc4 6 3 3 3>;
> bus-width property is assigned as 4 (see above bus-width = <4>;) but
> here you are configuring 8 __data line__ . Any reason?
> I am not sure if Arndale board supports 8 bit bus-width, in any case
> either change the bus-width or gpios properties accordingly.

Right. As per the schematics, Arndale supports 4-bit bus-width. I will
remove the extra GPIO lines.

[ ... ]

> 
> with the above fix fill free to add
>    Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> 

Thanks for reviewing. I will re-submit the patch with your ack.

-- 
Tushar Behera

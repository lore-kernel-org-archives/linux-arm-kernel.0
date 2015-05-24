From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 24 May 2015 10:49:41 +0530
Subject: [PATCHv5 2/5] ARM: dts: Odroid-XU3 Enable TMU at Exynos5422 base
In-Reply-To: <CAJKOXPcQBVaaS+32GYpyQHQ3m_EZYqu0noXtpp_FVBEaGyUgGw@mail.gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-3-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPca-2qdYOoMQOnu0jigOYwUvMTWZwdM2kRTkBXw-ws4yw@mail.gmail.com>
 <CANAwSgQ=30j4A_nCd26kzxi=rdsh32+Srwuc5EaJigLhJ2r4jA@mail.gmail.com>
 <CAJKOXPfC9nGEsYJ3qJ6m_iMsB=D8_6sOEpLQzEvmLry5zS5j3g@mail.gmail.com>
 <CANAwSgTOaz+mMhFZTeXYoXF+xPR2qon2Tkfsw5aqO42AK1m1-Q@mail.gmail.com>
 <CAJKOXPd_1rTZZCz66nQKidUOOEBmgUD+05fHUBvXN-VuD5mTCw@mail.gmail.com>
 <CANAwSgTbjmSxhJj4o2pnD5pR2V9JbQ3az+TSSCDwgwNnvF7P9w@mail.gmail.com>
 <CAJKOXPcQGnc1O9-MwqeNwsQE3ax1n8nvad4Sqt47NYKnOSmJPg@mail.gmail.com>
 <CADoNuNfuDCn_vvACc0=xj0MjdKr4pYcj_-Xh0--Q8_qciuW5YA@mail.gmail.com>
 <CANAwSgSyoesxQG9hBj3KfBb_5CiqUrHWbkUymU3LYcKOnLdOzA@mail.gmail.com>
 <555D20E1.3070308@samsung.com>
 <CANAwSgQzYvmquo9fcUPLK5XHqo1G=HYHc-YuhUvtw2yYaDi9GA@mail.gmail.com>
 <CAJKOXPcQBVaaS+32GYpyQHQ3m_EZYqu0noXtpp_FVBEaGyUgGw@mail.gmail.com>
Message-ID: <CANAwSgTeHvrHxOY+RmDm2_3jtQocVwmnDCRAbzkndv21QtQTkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2015 at 10:03, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> 2015-05-24 2:35 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> Hi Krzysztof,
>>
>> I did some debugging on the this using powerdebug utility.
>> Using  LDO7 to control TMU seams to me correct option compared to BUCK3.
>>
>> Setting LDO7 to control TMU I observed  following output on powerdebug.
>> I observed that the power drawn by the board on Odroid show is much
>> less compare to BUCK3 on the same setup.
>> I can see the HDMI output on Odroid-V2 display screen.
>> I have done some stress testing on this configuration and It worked correctly.
>>
>> Powerdebug output using LDO7
>> ---------------------------------------------------------------------------------------------------------------
>> PowerDebug 0.7.3     Clocks  Regulators  Sensors  Gpio
>> Name        Status      State       Type        Users       Microvolts
>>  Min u-volts Max u-volts
>> phy                                             0           0
>>  0           0
>> phy                                             0           0
>>  0           0
>> vdd_ldo1                enabled     voltage     0           1000000
>>  1000000     1000000
>> LDO1                                            0           0
>>  0           0
>> LDO2                    enabled     voltage     0           1800000
>>  0           0
>> vdd_ldo3                enabled     voltage     0           1800000
>>  1800000     1800000
>> LDO3                                            0           0
>>  0           0
>> LDO4                    enabled     voltage     0           1800000
>>  0           0
>> vdd_ldo5                enabled     voltage     0           1800000
>>  1800000     1800000
>> LDO5                                            0           0
>>  0           0
>> vdd_ldo6                enabled     voltage     0           1000000
>>  1000000     1000000
>> hdmi        okay                                0           0
>>  0           0
>> hdmi        okay                                0           0
>>  0           0
>> LDO6                                            0           0
>>  0           0
>> vdd_ldo7                enabled     voltage     0           1800000
>>  1800000     1800000
>> hdmi        okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> LDO7                                            0           0
>>  0           0
>> vdd_ldo8                enabled     voltage     0           1800000
>>  1800000     1800000
>> LDO8                                            0           0
>>  0           0
>> vdd_ldo9                enabled     voltage     0           3000000
>>  3000000     3000000
>> LDO9                                            0           0
>>  0           0
>>
>> Powerdebug output using BUCK3.
>> --------------------------------------------------------------------------------------------------------------------------
>> PowerDebug 0.7.3     Clocks  Regulators  Sensors  Gpio
>> Name        Status      State       Type        Users       Microvolts
>>  Min u-volts Max u-volts
>> LDO21                   disabled    voltage     0           1800000
>>  0           0
>> LDO22                   disabled    voltage     0           1200000
>>  0           0
>> LDO23                   enabled     voltage     0           1100000
>>  0           0
>> tsp_io                  enabled     voltage     0           2800000
>>  2800000     2800000
>> LDO24                                           0           0
>>  0           0
>> LDO25                   disabled    voltage     0           1800000
>>  0           0
>> vdd_ldo26               enabled     voltage     0           3000000
>>  3000000     3000000
>> LDO26                                           0           0
>>  0           0
>> LDO27                   enabled     voltage     0           1000000
>>  0           0
>> LDO28                   disabled    voltage     0           3300000
>>  0           0
>> LDO29                   disabled    voltage     0           1800000
>>  0           0
>> LDO30                   disabled    voltage     0           1800000
>>  0           0
>> LDO31                   disabled    voltage     0           1800000
>>  0           0
>> LDO32                   disabled    voltage     0           1800000
>>  0           0
>> LDO33                   disabled    voltage     0           1800000
>>  0           0
>> LDO34                   disabled    voltage     0           3000000
>>  0           0
>> LDO35                   disabled    voltage     0           1600000
>>  0           0
>> LDO36                   disabled    voltage     0           1800000
>>  0           0
>> LDO37                   disabled    voltage     0           1800000
>>  0           0
>> LDO38                   disabled    voltage     0           2800000
>>  0           0
>> vdd_mif                 enabled     voltage     0           1100000
>>  800000      1300000
>> BUCK1                                           0           0
>>  0           0
>> vdd_arm                 enabled     voltage     0           1000000
>>  800000      1500000
>> BUCK2                                           0           0
>>  0           0
>> vdd_int                 enabled     voltage     0           1000000
>>  800000      1400000
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> tmu         okay                                0           0
>>  0           0
>> BUCK3                                           0           0
>>  0           0
>> vdd_g3d                 enabled     voltage     0           1000000
>>  800000      1400000
>> BUCK4                                           0           0
>>  0           0
>> vdd_mem                 enabled     voltage     0           1200000
>>  800000      1400000
>> BUCK5                                           0           0
>>  0           0
>> vdd_kfc                 enabled     voltage     0           1025000
>>  800000      1500000
>>
>> So I would like to go with LDO7.
>>
>> Please share your thoughts.
>
> I don't understand how grepping through /sys/class/regulator helps in
> making this decision. I just don't get it. Can you please explain it
> to me?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

I am just trying to understand the how the DTS changes get mapped internally.
If their seem to be a problem with the changes, then I could figure it
out but doing some testing.

-Anand Moon

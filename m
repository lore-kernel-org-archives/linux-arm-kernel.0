From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 19 Dec 2013 02:13:21 +0000
Subject: [PATCH V3 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
In-Reply-To: <ADD49D66-30FE-4D87-88D6-F8AE07376F3F@freescale.com>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>,
 <CAOMZO5DCGOkUtWmEok-uEFsUpGLF+93Vhm9XFs02yH9Z+eV0uQ@mail.gmail.com>
 <ADD49D66-30FE-4D87-88D6-F8AE07376F3F@freescale.com>
Message-ID: <112fab48e08c43749c0797328b1f1ee1@DM2PR03MB317.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Huang Yongcai-B20788
>Sent: Wednesday, December 18, 2013 8:01 PM
>To: Fabio Estevam
>Cc: Huang Yongcai-B20788; Shawn Guo; rjw at rjwysocki.net; Viresh Kumar;
>devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>cpufreq at vger.kernel.org; linux-pm at vger.kernel.org
>Subject: Re: [PATCH V3 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
>
>
>
>Sent from Anson's iPhone
>
>> ? 2013?12?18??19:08?"Fabio Estevam" <festevam@gmail.com> ???
>>
>> Hi Anson,
>>
>>> On Wed, Dec 18, 2013 at 7:26 PM, Anson Huang <b20788@freescale.com> wrote:
>>>
>>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>>> +  arm-supply: vddarm input.
>>> +  pu-supply: vddpu input.
>>> +  soc-supply: vddsoc input.
>>
>> I found these messages confusing, as someone may think that you are
>> referring to the VDD_ARM_IN/VDD_ARM23_IN and VDD_SOC_IN, which are
>> really inputs.
>>
>> What about doing this instead?
>>
>> arm-supply: VDDARM LDO output
>> pu-supply:  VDDPU LDO output
>> soc-supply: VDDSOC LDO output
>
>I think they should know these regulators mean the arm, soc/pu's real working
>voltage, as you know, our i.MX6 also support LDO bypass mode, then these
>regulators can be VDDXXX_IN. that is why I use vddxxx input, not vddxxx LDO
>input.Thanks!

After re-consideration, I think below should be better:
arm-supply: regulator node supplying arm.
pu-supply: regulator node supplying pu.
soc-supply: regulator node supplying soc.

Anson 


>>
>> Regards,
>>
>> Fabio Estevam
>>
>>

From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Apr 2017 14:02:51 -0300
Subject: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
In-Reply-To: <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
 <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
Message-ID: <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 2:02 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Leonard,
>
> On Tue, Apr 25, 2017 at 1:57 PM, Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
>> The board file for imx6sx-dbg overrides cpufreq operating points to use
>> higher voltages. This is done because the board has a shared rail for
>> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
>> needs to be a value suitable for both ARM and SOC.
>>
>> This was introduced in:
>>
>> commit 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")
>>
>> This only only applies to LDO bypass mode, a feature not present in
>> upstream. When LDOs are enabled the effect is to use higher voltages than
>> necesarry for no good reason.
>>
>> Setting these higher voltages can make some boards fail to boot with ugly
>> semi-random crashes, reminiscent of memory corruption. These failures
>> happen the first time the lowest idle state is used. Remove the OPP
>> override in order to fix those crashes.
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> ---
>> It's not clear exactly why the crashes happen. Perhaps waking up from idle
>> draws more power than is available? Removing this override is a correct
>> change anyway so maybe there is no need to investigate deeper.
>
> Marek just sent a similar one a few minutes ago:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503230.html

Forgot to add Marek.

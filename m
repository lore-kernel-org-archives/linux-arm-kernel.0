From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 13:49:13 +0200
Subject: [PATCH] ARM: qcom_defconfig: enable RPMSG_QCOM_SMD
In-Reply-To: <20170621050335.GI17640@tuxbook>
References: <20170615061521.21292-1-bshah@kde.org>
 <20170621050335.GI17640@tuxbook>
Message-ID: <CAK8P3a1ChrTPYC37sZhkF2edfBGOR4m5eFe8=4-y=R-FaVFdMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 7:03 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> + arm at kernel.org
>
> On Wed 14 Jun 23:15 PDT 2017, Bhushan Shah wrote:
>
>> As of commit 5052de8deff56, QCOM_SMD_RPM and various other config
>> options enabled in the qcom_defconfig depends on the RPMSG. If
>> QCOM_SMD_RPM config option is not selected it disables the
>> REGULATOR_QCOM_SMD_RPM and other essential config options.
>>
>> Signed-off-by: Bhushan Shah <bshah@kde.org>
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I see that Andy Gross was not on Cc, he would be the right person to
pick up patches like this one.

Andy, do you want to pick that up through the qcom tree, or should
we apply it directly on arm-soc?

      Arnd

>> I believe this patch should be included in the current rc version as well
>> otherwise boards that depend on pm8941 are not functional (for example
>> msm8974-hamerhead had emmc not working).
>>
>>  arch/arm/configs/qcom_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
>> index 07666a7a9de5..65356a3a9253 100644
>> --- a/arch/arm/configs/qcom_defconfig
>> +++ b/arch/arm/configs/qcom_defconfig
>> @@ -173,6 +173,7 @@ CONFIG_LEDS_GPIO=y
>>  CONFIG_LEDS_PM8058=y
>>  CONFIG_LEDS_TRIGGERS=y
>>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>> +CONFIG_RPMSG_QCOM_SMD=y
>>  CONFIG_RTC_CLASS=y
>>  CONFIG_RTC_DRV_PM8XXX=y
>>  CONFIG_DMADEVICES=y

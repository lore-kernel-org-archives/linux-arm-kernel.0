From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 26 Jun 2014 02:53:00 +0000
Subject: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
In-Reply-To: <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
References: <1403687412-22362-1-git-send-email-b20788@freescale.com>
 <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
Message-ID: <135a42da42024542b0f7a034ef1d63df@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio
	I have already sent cpufreq driver patch for review which is supporting i.MX6SX, you may need to add it by yourself if you want to test it, I attached the patch, hope it helps. 

Best Regards.
Anson Huang
?
Freescale Semiconductor Shanghai
Tel:021-28937058


>-----Original Message-----
>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Thursday, June 26, 2014 9:23 AM
>To: Huang Yongcai-B20788
>Cc: Guo Shawn-R65073; Sascha Hauer; Russell King; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
>
>Hi Anson,
>
>On Wed, Jun 25, 2014 at 6:10 AM, Anson Huang <b20788@freescale.com> wrote:
>> Add cpufreq support for i.MX6SX, using common i.MX6Q cpufreq driver.
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>>  arch/arm/mach-imx/mach-imx6sx.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx6sx.c
>> b/arch/arm/mach-imx/mach-imx6sx.c index 74ff7d6..9221e1d 100644
>> --- a/arch/arm/mach-imx/mach-imx6sx.c
>> +++ b/arch/arm/mach-imx/mach-imx6sx.c
>> @@ -42,6 +42,9 @@ static void __init imx6sx_init_irq(void)  static
>> void __init imx6sx_init_late(void)  {
>>         imx6q_cpuidle_init();
>> +
>> +       if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
>> +               platform_device_register_simple("imx6q-cpufreq", -1,
>> + NULL, 0);
>>  }
>
>With this patch applied I get a flood of these messages:
>
>cpu cpu0: failed to scale vddpu up: -22
>cpufreq: __target_index: Failed to change cpu frequency: -22 cpu cpu0: failed
>to scale vddpu up: -22
>cpufreq: __target_index: Failed to change cpu frequency: -22 cpu cpu0: failed
>to scale vddpu up: -22
>cpufreq: __target_index: Failed to change cpu frequency: -22
>
>Any suggestions?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-imx6-remove-pu-regulator-dependency-for-SOCs.patch
Type: application/octet-stream
Size: 3415 bytes
Desc: 0001-cpufreq-imx6-remove-pu-regulator-dependency-for-SOCs.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140626/d2877930/attachment-0001.obj>

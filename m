From: liguozhu@hisilicon.com (Liguozhu (Kenneth))
Date: Mon, 17 Aug 2015 01:28:07 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvNV0gbmV0OiBhZGQgSGlzaWxpY29uIE5ldHdvcmsg?=
 =?gb2312?Q?Subsystem_support_(config_and_documents)?=
In-Reply-To: <1536926.jEJjsM70Lj@wuerfel>
References: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
 <1439548222-231611-2-git-send-email-liguozhu@hisilicon.com>
 <1536926.jEJjsM70Lj@wuerfel>
Message-ID: <161EFA05D917D0419F95C4CAEEF86C1094E95FAA@SZXEMA504-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Arnd. 

Regarding the ae-name: it is the name of the Acceleration Engine. It is provided by the BIOS according to the position and the feature enabled of the IP. So "soc0" means it is on SoC No. 0, while "n4" means it is running on "Non-dsaf mode 4". Ideally, we should setup the rule to name it. But as I said in the patchset, the IP is original designed for a bare metal solution, it is worthless to export all modes and we are planning to add more mode for Linux itself in the IP in future version. So I think the better way is to leave it as a "name" but add more meaning in the future.

Regarding the ae-opts: it is the initial value for the AE's runtime options, Currently, we have only "port number" (there are 6XGE+2GE port for a DSAF AE) as option. But for future version, we will add other options such as "enable Spanning Tree Protocol algorithm)" and so on. 

Should I add these background to somewhere?

Best Regards
-Kenneth Lee (Hisilicon)
__________________________________________________________
????????????????????????????????????????
????????????????????????????????????????
???????????????????????????????????
This e-mail and its attachments contain confidential information from HUAWEI, which 
is intended only for the person or entity whose address is listed above. Any use of the 
information contained herein in any way (including, but not limited to, total or partial 
disclosure, reproduction, or dissemination) by persons other than the intended 
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by 
phone or email immediately and delete it!




-----????-----
???: Arnd Bergmann [mailto:arnd at arndb.de] 
????: 2015?8?15? 4:50
???: Liguozhu (Kenneth)
??: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org; catalin.marinas at arm.com; will.deacon at arm.com; Zhuangyuzeng (Yisen); davem at davemloft.net; paul.gortmaker at windriver.com; Dingtianhong; zhangfei.gao at linaro.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; netdev at vger.kernel.org; Linuxarm; Salil Mehta; huangdaode; Liguozhu (Kenneth)
??: Re: [PATCH 1/5] net: add Hisilicon Network Subsystem support (config and documents)

On Friday 14 August 2015 18:30:18 Kenneth Lee wrote:
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> new file mode 100644
> index 0000000..5ab6969
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> @@ -0,0 +1,14 @@
> +Hisilicon Network Subsystem NIC controller
> +
> +Required properties:
> +- compatible: hisilicon,hns-nic
> +- ae-name: accelerator name who provide this interface
> +- ae-opts: options (string) to the accelerator. e.g. the index interface
> +
> +Example:
> +
> +       ethernet at 0{
> +               compatible = "hisilicon,hns-nic";
> +               ae-name = "soc0-n4";
> +               ae-opts = "0";
> +       };
> 

These properties look very unconventional. What are the valid strings
for ae-name and ae-opts? It looks like the latter is just a number,
so why not use an integer property?

	Arnd

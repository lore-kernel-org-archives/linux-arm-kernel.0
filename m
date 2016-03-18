From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 18 Mar 2016 15:08:58 +0800
Subject: Linux kernel 4.1 boot on arm64 stuck in cpu_do_idle
In-Reply-To: <DB5PR04MB21663013F59C3F0DA1FBFB41F88C0@DB5PR04MB2166.eurprd04.prod.outlook.com>
References: <DB5PR04MB21663013F59C3F0DA1FBFB41F88C0@DB5PR04MB2166.eurprd04.prod.outlook.com>
Message-ID: <56EBA98A.90306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/18 14:26, Sakar Arora wrote:
> Hi
> 
> Trying to boot custom kernel 4.1 using UEFI bootloader. Using debugger it is seen the PC is in the cpu_do_idle function inside proc.S (the stack traces the call to rest_init() function)
> 
> It seems that the init process is not getting scheduled. Can somebody suggest a debug strategy for this?

1) check the configuration of uart8250, like interrupt in dts.
2) check gic in uefi, I met similar situation ago,
   it leads to lost interrupt, due to the wrong configuration of gic.
3) time issue ?

BRs,
Kefeng

> 
> Thanks
> Sakar
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 

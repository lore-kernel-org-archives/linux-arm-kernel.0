From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Sat, 28 Feb 2015 14:01:51 +0800
Subject: [PATCH v8 0/2] mtd: hisilicon: add a new driver for NAND
 controller of hisilicon hip04 Soc
In-Reply-To: <20150208083514.GD3670@norris-Latitude-E6410>
References: <1422183194-10148-1-git-send-email-wangzhou1@hisilicon.com>
 <20150208083514.GD3670@norris-Latitude-E6410>
Message-ID: <54F159CF.9090208@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/8 16:35, Brian Norris wrote:
> On Sun, Jan 25, 2015 at 06:53:12PM +0800, Zhou Wang wrote:
>> This patchset adds the support for NAND controller of hisilicon hip04 Soc.
>> The NAND controller IP was developed by hisilicon and needs a new driver to
>> support it. This patchset is based on l2-mtd/master.
>>
>> I have tested this NAND flash controller driver in Hip04 D01 board using MTD
>> test modules. All testes passed except mtd_nandbiterrs. The reason is that this
>> NAND controller doesn't support to write raw page in ECC mode. In the test of
>> mtd_nandbiterrs, when rewriting raw page(with some bits changed) back, this NAND
>> controller will also produce ECC codes and write into NAND flash OOB area. As
>> ECC codes in OOB area have been broken, read error comes out as follow.
>>
>> Hi Brian,
>>
>> As the patch have been reviewed for some time, could you consider to take this
>> driver for v3.20? If there is something still not good, please let me know.
> 
> It's all looking good. Pushed to l2-mtd.git, probably for 3.20. I have
> one or two small comments that may be worth thinking about though.
> 
> Brian
> 
> .
>
Hi Brian,

Thanks a lot.

Zhou Wang

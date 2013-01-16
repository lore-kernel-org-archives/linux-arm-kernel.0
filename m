From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 16 Jan 2013 16:28:44 +0800
Subject: [PATCH 1/3] MTD: at91: atmel_nand: for PMECC, add code to choose
 the ecc bits and sector size according to the ONFI parameter ECC
 requirement.
In-Reply-To: <1358252760.2731.133.camel@sauron.fi.intel.com>
References: <1355912840-29501-1-git-send-email-josh.wu@atmel.com>
 <1355912840-29501-2-git-send-email-josh.wu@atmel.com>
 <1358252760.2731.133.camel@sauron.fi.intel.com>
Message-ID: <50F664BC.7@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

On 1/15/2013 8:26 PM, Artem Bityutskiy wrote:
> I cannot compile this patch:
>
> ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"
>
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[2]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2

As Bo Shen already mentioned, they are caused by ssc pinctrl patches. it 
will be merged in next rc or late.

>
> On Wed, 2012-12-19 at 18:27 +0800, Josh Wu wrote:
>> This patch will check NAND flash's ecc minimum requirement in ONFI parameter. If it is equal or smaller than pmecc-cap in dtsi, then use ecc_bits in ONFI. otherwise, return an error since pmecc-cap in dtsi don't meet the ecc minimum reqirement.
>>
>> This patch also check sector size (codeword) requirement in ONFI. If it is equal or bigger than sector_size in dtsi, then use the one of ONFI. otherwise return error.
>>
>> Currently we don't support to read the ECC parameter in ONFI extended parameter page. So in that case we just use the value specified in dts.
>>
>> For non-ONFI nand flash, we assume the minimum ecc requirement is 2bits in 512 bytes.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Please, wrap the lines like kernel developers usually do.

OK. I will resend the whole patch series with wrapped commit message. 
thanks.

Best Regards,
Josh Wu
>

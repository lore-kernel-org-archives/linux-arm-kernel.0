From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 24 May 2017 11:31:10 +0300
Subject: [PATCH 05/12] arm64: dts: Add I2C nodes for Hi3660
In-Reply-To: <10a19a02-21ac-364e-ab5c-de8aa16c3858@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-6-guodong.xu@linaro.org>
 <20170523003908.ztuh4oohdk3g34pm@rob-hp-laptop>
 <94d06900-d871-7bc6-e1f3-d2b22ba20aaf@linaro.org>
 <CAL_JsqJUH-TOufw=dtpgDww_VEvyTW_LZuSQqRSU-cYbAqfJ6A@mail.gmail.com>
 <10a19a02-21ac-364e-ab5c-de8aa16c3858@linaro.org>
Message-ID: <a45b3ab7-4f77-be0a-6382-a94e43fd512e@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2017 05:34 AM, zhangfei wrote:
> Rob suggest add something like "hisilicon,hi3660-dw-i2c" as well.
> "The problem is dw-i2c does not give any clue as to what the
> configuration or version of the IP is.
> Is that fully discoverable with version/capability registers? If not
> then you need a specific compatible.
> Generally when we have not required them, it ends up being a problem
> later on."
>
Some features are discoverable from DW_IC_COMP_PARAM_1, 
DW_IC_COMP_VERSION and DW_IC_COMP_TYPE registers. Although my 
specification does not document what's inside of DW_IC_COMP_VERSION and 
DW_IC_COMP_TYPE but code is using them.

>
> While Documentation/devicetree/bindings/i2c/i2c-designware.txt
> compatible : should be "snps,designware-i2c"
>
> Besides, on Hikey960,
> [    3.822353] dw_readl(dev, DW_IC_COMP_VERSION)=0x3132302a
> [    3.827763] dw_readl(dev, DW_IC_COMP_TYPE)=0x44570140
> Are these two registers enough to distinguish version etc?
>
I've seen DW_IC_COMP_VERSION being 0x3131352a or 0x3132312a in our 
platforms. DW_IC_COMP_TYPE has the same value what you are seeing.

-- 
Jarkko

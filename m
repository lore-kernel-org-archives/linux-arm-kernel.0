From: zhangfei.gao@linaro.org (zhangfei)
Date: Mon, 10 Mar 2014 11:36:58 +0800
Subject: clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <20140303121335.GA10177@elgon.mountain>
References: <20140303121335.GA10177@elgon.mountain>
Message-ID: <531D335A.5060309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks Dan

Sorry, not check with smatch, only check with checkpatch.pl & sparse.
Will take care next time.

On 03/03/2014 08:13 PM, Dan Carpenter wrote:
> Hello Zhangfei Gao,
>
> The patch 62ac983b6141: "clk: hisilicon: add hi3620_mmc_clks" from
> Jan 13, 2014, leads to the following static checker warning:
>
> 	drivers/clk/hisilicon/clk-hi3620.c:338 mmc_clk_delay()
> 	warn: always true condition '(para >= 0) => (0-u32max >= 0)'
>
> drivers/clk/hisilicon/clk-hi3620.c
>     334  static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
>     335  {
>     336          u32 i;
>     337
>     338          if (para >= 0) {
>                      ^^^^^^^^^
> Wat?
>
>     339                  for (i = 0; i < len; i++) {
>     340                          if (para % 2)
>     341                                  val |= 1 << (off + i);
>     342                          else
>     343                                  val &= ~(1 << (off + i));
>     344                          para = para >> 1;
>     345                  }
>     346          }
>     347          return val;
>     348  }
>
> regards,
> dan carpenter
>

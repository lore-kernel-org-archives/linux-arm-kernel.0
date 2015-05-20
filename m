From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 20 May 2015 07:23:58 -0700
Subject: [RESEND PATCH 0/2] pinctrl: zynq: fix two bugs of zynq pinmux
 function
In-Reply-To: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
References: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150520142358.GS31550@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On Wed, 2015-05-20 at 05:42PM +0900, Masahiro Yamada wrote:
> 
> I sent the previous one to linux-serial by mistake.
> I am resending to linux-gpio, dropping linux-serial.
> Sorry for noise.
> 
> 
> 
> Masahiro Yamada (2):
>   pinctrl: zynq: fix DEFINE_ZYNQ_PINMUX_FUNCTION_MUX macro
>   pinctrl: zynq: fix offset address for {SD0,SD1}_WP_CD_SEL

For the series:
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

I'm not sure how severe the impact of these bugs is. It looks like the
the current driver could corrupt the register for MIO pin0, am I right?
It may be a good ides to add
  Fixes: add958cee967 "pinctrl: Add driver for Zynq"
(I suspect that bug is there from the beginning) and ask Linus to
consider this for stable.

	Thanks,
	S?ren

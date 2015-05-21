From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 21 May 2015 23:31:54 +0900
Subject: [RESEND PATCH 0/2] pinctrl: zynq: fix two bugs of zynq pinmux
 function
In-Reply-To: <20150520142358.GS31550@xsjsorenbubuntu>
References: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
 <20150520142358.GS31550@xsjsorenbubuntu>
Message-ID: <CAK7LNARutQyESi90faNUC0LvCQ3woS8wUvHLDw5emcBOza9eng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,


2015-05-20 23:23 GMT+09:00 S?ren Brinkmann <soren.brinkmann@xilinx.com>:
> Hi Masahiro,
>
> On Wed, 2015-05-20 at 05:42PM +0900, Masahiro Yamada wrote:
>>
>> I sent the previous one to linux-serial by mistake.
>> I am resending to linux-gpio, dropping linux-serial.
>> Sorry for noise.
>>
>>
>>
>> Masahiro Yamada (2):
>>   pinctrl: zynq: fix DEFINE_ZYNQ_PINMUX_FUNCTION_MUX macro
>>   pinctrl: zynq: fix offset address for {SD0,SD1}_WP_CD_SEL
>
> For the series:
> Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>
> I'm not sure how severe the impact of these bugs is. It looks like the
> the current driver could corrupt the register for MIO pin0, am I right?

Right.
DEFINE_ZYNQ_PINMUX_FUNCTION_MUX() is missing the .mux
so it is always set to zero, i.e. MIO pin0 register is corrupted.


> It may be a good ides to add
>   Fixes: add958cee967 "pinctrl: Add driver for Zynq"
> (I suspect that bug is there from the beginning) and ask Linus to
> consider this for stable.

Yes, looks like these two bugs have been there
since the introduction of this driver.

For the series,
Fixes: add958cee967 (pinctrl: Add driver for Zynq)

Linus,
Could you consider this series for stable and linux-4.1, please?


-- 
Best Regards
Masahiro Yamada

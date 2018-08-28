From: jian.hu@amlogic.com (Jian Hu)
Date: Tue, 28 Aug 2018 11:35:32 +0800
Subject: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
In-Reply-To: <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
 <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
 <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
 <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
 <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
Message-ID: <977d8010-6d82-5eac-5da5-6dbe0f73971a@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi: Jerome

On 2018/8/27 21:07, Jerome Brunet wrote:
> On Fri, 2018-08-24 at 21:34 +0800, Jian Hu wrote:
>>>
>>
>> I am confued about aoclk81's parent clocks.
>>
>> I can not get the example of axg audio clock driver, Could you provide
>> the link? Had it merged into clk-meson.git?
> 
> Yes and mainline as well : drivers/clk/meson/axg-audio.c
> 
> Basically this driver is creating bypass input clocks (audio_pclk, mst_in[0-9],
> etc...) .
> 
> This allows to collect input clocks from DT (like any consumer should) will
> keeping constant in the controller clock tree.
> 
>>From what I've seen of your controller drivers, the EE controller should have
> one input, the AO should have 3.
> 
> 
> 
> .
> 
I still can not get the example meaning in axg audio driver.

In 26 page of A113D_Datasheet V0.7 20170725-Baylibre.pdf,We can see the 
aoclk81 has two parents. clk81 and ao_slow_clk. I can not get 3 parents.

                          clk81|\
                        -------| \        aoclk81
src0 |\                       |  |-------------------
-----| \     ao_slow_clk      |  |
      |  |---------------------| /
-----| /                      |/
  src1|/


src0 is from xtal, if can generate 32k clock, but it is never used.
src1 is from gpio clock, It is never used. If necessary? the ao_slow_clk 
maybe described.

So why aoclk81 has 3 parents?

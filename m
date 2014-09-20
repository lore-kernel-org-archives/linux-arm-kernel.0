From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sat, 20 Sep 2014 20:06:21 +0200
Subject: [PATCH 4/7] clk: add clk-asm9260 driver
In-Reply-To: <20140918075650.GB29620@piout.net>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
 <1410646408-28901-5-git-send-email-linux@rempel-privat.de>
 <20140917135440.GG27054@piout.net> <541A7FE1.8060202@rempel-privat.de>
 <20140918075650.GB29620@piout.net>
Message-ID: <541DC21D.7050303@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.09.2014 um 09:56 schrieb Alexandre Belloni:
> Hi,
> 
> On 18/09/2014 at 08:46:57 +0200, Oleksij Rempel wrote :
>> Am 17.09.2014 um 15:54 schrieb Alexandre Belloni:
>>> Hi,
>>>
>>> Please have a look at https://lkml.org/lkml/2014/5/14/598 which describe
>>> the preferred way of implementing clocks in the CCF where you only
>>> declare the clock generator in the DT instead of each separate clocks.
>>
>> hm... if i see it correctly. i will need to move almost everything from
>> DT to clk-driver. And i will need to create separate driver for other
>> SoC provided by AlphaScale. On other side with current (generic) driver
>> i will need only to change DT and it will work.
>>
>> May be instead of going qcom way, it will be better to have generic
>> gate, div and mux bindings for DT? Sure it will make DT a bit fuzzy, but
>> it will dramatically reduce kernel code and reduce the time of providing
>> code to upstream.
>>
>> I don't think drivers/clk/qcom/gcc-msm8974.c is less complicated solution.
> 
> IT is not less complicated but it is more flexible (for exemple when
> setting flags on individual clocks, like CLK_SET_RATE_PARENT or
> CLK_IGNORE_UNUSED). Describing all the individual clocks in DT is a
> mistake we made in at91 and it will definitely bother you in the future,
> for example when you realize that your clock controller is also taking
> care of reset or power management.
> 
> Also, this is the kind of driver you write only once per SoC so it is
> about the same doing it in DT or in C with the added advantage that
> doing it in C takes less memory and is probably faster.
> 
> You can have a look at how it has been done for the berlin SoCs to see
> how you can easily reuse code between drivers.

What is the correct way to handle/define i2s MCLK input? I have I2S mux
clock with choice of 3 sources: Xtal, PLL and MCLK. One of pins can be
configured as MCLK src. Should i define fixedrate-clk?

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/0b0c4daf/attachment.sig>

From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Jan 2015 10:24:04 +0800
Subject: [PATCH v3 05/13] ARM: dts: sun9i: Add clock-indices property for
 bus gate clocks
In-Reply-To: <20150114163351.GY4891@lukather>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-6-git-send-email-wens@csie.org>
 <20150114163351.GY4891@lukather>
Message-ID: <CAGb2v64brc_2c5Jz2=BzfCpwiwBQgGf=SLD2ib+taOYUgicekA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 12:33 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jan 13, 2015 at 09:37:27AM +0800, Chen-Yu Tsai wrote:
>> of_clk_get_parent_name() uses the clock-indices property to resolve
>> clock phandle arguments in case that the argument index does not
>> match the clock-output-names sequence.
>>
>> This is the case on sunxi, where we use the actual bit index as the
>> argument to the phandle. Add the clock-indices property so that
>> of_clk_get_parent_name() resolves the names correctly.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied. Are the mask in the clock driver still of any use now? I
> don't think they are, and if we're going that way, I'd rather have
> them removed from the driver.

Yes they are still passed through factors_data, for mux_clk_ops to
know about the width of the mux, which is 3 bits on older SoCs vs
4 bits on sun9i.

ChenYu

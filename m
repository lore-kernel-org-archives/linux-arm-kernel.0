From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 12 May 2014 16:45:08 -0300
Subject: [linux-sunxi] [PATCH 3/6] clk: sunxi: Move the GMAC clock to
 a file of its own
In-Reply-To: <20140512193646.GE17154@lukather>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399692821-20988-4-git-send-email-maxime.ripard@free-electrons.com>
 <536E5CBB.5070605@elopez.com.ar> <20140512193646.GE17154@lukather>
Message-ID: <537124C4.5080303@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 12/05/14 16:36, Maxime Ripard escribi?:
> On Sat, May 10, 2014 at 02:07:07PM -0300, Emilio L?pez wrote:
>>> +
>>> +	clk = clk_register_composite(NULL, clk_name,
>>> +			parents, SUN7I_A20_GMAC_PARENTS,
>>> +			&mux->hw, &clk_mux_ops,
>>> +			NULL, NULL,
>>> +			&gate->hw, &clk_gate_ops,
>>> +			0);
>>> +
>>> +	if (IS_ERR(clk))
>>> +		goto iounmap_reg;
>>> +
>>> +	of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>> +	clk_register_clkdev(clk, clk_name, NULL);
>>
>> As I mentioned on the other email, I don't think we are using
>> clkdev. Maybe we can drop it.
>
> No we aren't, but we should not really modify code while moving it. I
> can send another patch to do so, but that should not prevent this code
> from going in.

That would be great :) The patches themselves are okay, I just thought 
I'd mention it so it's not forgotten.

Cheers,

Emilio

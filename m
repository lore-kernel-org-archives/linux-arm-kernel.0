From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 21 Jul 2017 15:29:32 +0200
Subject: [PATCH v2 1/4] net: phy: at803x: Document RGMII RX and TX clock
 delay issues
In-Reply-To: <a9d3777c-1752-d79b-8302-d09c5f736a9f@codeaurora.org>
References: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
 <051653a2-946f-6a0b-4cff-b403d1197038@sigmadesigns.com>
 <a9d3777c-1752-d79b-8302-d09c5f736a9f@codeaurora.org>
Message-ID: <db666f79-5ee3-f136-527e-aeb9cc6425b7@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/2017 15:20, Timur Tabi wrote:

> On 7/21/17 6:25 AM, Marc Gonzalez wrote:
>
>> +	 * NB: This code assumes that RGMII RX clock delay is disabled
>> +	 * at reset, but actually, RX clock delay is enabled at reset.
> 
> Could we change this to say, "RX clock delay is enabled at reset on some 
> systems."?  Otherwise, it implies that the code is wrong 100% of the 
> time and should be fixed, not documented.

I don't understand what you're saying.

It is a correct observation that the code enabling
RGMII RX clock delay is a NOP, since that bit will
always be set at that point.

The spec for the 8035 (I haven't checked for 8030 and 8031,
is that what you meant by "other systems"?) states that
Sel_clk125m_dsp, which is described as:
"Control bit for rgmii interface rx clock delay"
is 1 after HW reset, 1 after SW reset.

So my statement "RX clock delay is enabled at reset"
is universally true. It's not just on some systems.

What am I missing?

Regards.

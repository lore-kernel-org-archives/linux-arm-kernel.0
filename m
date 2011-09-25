From: mturquette@ti.com (Turquette, Mike)
Date: Sat, 24 Sep 2011 22:27:24 -0700
Subject: [PATCH v2 4/7] clk: Add simple gated clock
In-Reply-To: <20110925040217.GO24631@ponder.secretlab.ca>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-5-git-send-email-mturquette@ti.com>
	<20110925040217.GO24631@ponder.secretlab.ca>
Message-ID: <CAJOA=zOWMR2R2CjZbnCOWQ_R1ZA+aOUejzm-t8OMzbFmc+U2Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 9:02 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Sep 22, 2011 at 03:26:59PM -0700, Mike Turquette wrote:
>> From: Jeremy Kerr <jeremy.kerr@canonical.com>
>>
>> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> ---
>> Changes since v1:
>> Add copyright header
>> Fold in Jamie's patch for set-to-disable clks
>> Use BIT macro instead of shift
>>
>> ?drivers/clk/Kconfig ? ?| ? ?4 ++
>> ?drivers/clk/Makefile ? | ? ?1 +
>> ?drivers/clk/clk-gate.c | ? 78 ++++++++++++++++++++++++++++++++++++++++++++++++
>> ?include/linux/clk.h ? ?| ? 13 ++++++++
>> ?4 files changed, 96 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/clk/clk-gate.c
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index d8313d7..a78967c 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -12,3 +12,7 @@ config GENERIC_CLK
>> ?config GENERIC_CLK_FIXED
>> ? ? ? bool
>> ? ? ? depends on GENERIC_CLK
>> +
>> +config GENERIC_CLK_GATE
>> + ? ? bool
>> + ? ? depends on GENERIC_CLK
>
> I see zero documentation on what a "gated clock" is supposed to be or
> how it works, and there are zero comments in the code. ?It's kind of
> hard to review that way, and even harder to use.

Will add Documentation and re-post.

Thanks,
Mike

> g.
>

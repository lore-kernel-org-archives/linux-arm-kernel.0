From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 9 Apr 2015 12:07:59 +0200
Subject: [PATCH 4/8] clk: tegra: Fix duplicate const for parent names
In-Reply-To: <20150409100036.GK12103@ulmo>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
 <1428499339-29569-5-git-send-email-k.kozlowski@samsung.com>
 <20150409100036.GK12103@ulmo>
Message-ID: <CAJKOXPd4KsZ-pLDUtyWwyJviZyFWQKVLTVpW_6_Yye2o=3xy0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-09 12:00 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Wed, Apr 08, 2015 at 03:22:15PM +0200, Krzysztof Kozlowski wrote:
>> Replace duplicated const keyword for 'emc_parent_clk_names' with proper
>> array of const pointers to const strings.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/clk/tegra/clk-emc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This would probably better go in via the Tegra tree since the patch that
> contains this has only made it to linux-next.
>
> Stephen, Mike, any objections to me taking this?

Applying this without the change for const-ness of parent_names (patch
by Sascha Hauer sent before mine [1]) would introduce a warning -
assign of const to non-const. Any idea to solve it? Immutable branch?

[1] http://marc.info/?i=1427825817-26773-2-git-send-email-s.hauer%40pengutronix.de

Best regards,
Krzysztof

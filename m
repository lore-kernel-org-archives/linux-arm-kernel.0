From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 5 Jul 2011 11:20:48 -0600
Subject: [PATCH 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
In-Reply-To: <20110705153509.GA14954@S2100-06.ap.freescale.net>
References: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
	<1309681851-23052-4-git-send-email-shawn.guo@linaro.org>
	<20110704062548.GI15152@ponder.secretlab.ca>
	<20110705153509.GA14954@S2100-06.ap.freescale.net>
Message-ID: <CACxGe6sxRZbWO_HzfCZzn2S=o06M=JyAiuLZig4v=cNgCuu9OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 9:35 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Mon, Jul 04, 2011 at 12:25:48AM -0600, Grant Likely wrote:
>> > + ? ?"none" : No CD
>> > + ? ?"controller" : Uses eSDHC controller internal CD signal
>> > + ? ?"gpio" : Uses GPIO pin for CD
>>
>> I would say the presence of a "cd-gpios" property would implicitly
>> mean gpio is to be used for the CD pin.
>>
> Yes, you are right. ?But I would say this is a direct translation of
> the existing platform_data. ?After all, we are sharing most of code
> path between platform and dt.

Meh, that's just implementation detail and the DT bindings should
*not* be focused on what Linux happens to currently do.  Define a
binding that makes sense first and foremost, and then make the driver
use it.

g.

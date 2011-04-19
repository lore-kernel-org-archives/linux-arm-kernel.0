From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Apr 2011 11:34:23 +0530
Subject: [PATCH] dmaengine: implement pause and resume for dw_dmac
In-Reply-To: <4DAD1DA5.7010801@st.com>
References: <1303173092-21785-1-git-send-email-linus.walleij@linaro.org>
	<4DAD1DA5.7010801@st.com>
Message-ID: <4DAD25E7.4030602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2011 10:59 AM, viresh kumar wrote:
> On 04/19/2011 06:01 AM, Linus Walleij wrote:
>> > It seems that the SPEAr needs this.
>> > 
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Thanks for sending this.
> Actually i wasn't sure that disabling channel will simply pause it, and not
> finish the transfer. So, didn't went for this change.
> 
>> > ---
>> >  drivers/dma/dw_dmac.c      |   22 ++++++++++++++++++++--
>> >  drivers/dma/dw_dmac_regs.h |    1 +
>> >  2 files changed, 21 insertions(+), 2 deletions(-)

Moreover, dwc_tx_status() must be updated to add following code:

	if (dwc->paused)
		return DMA_PAUSED;

Will do that while sending it in my patchset.

-- 
viresh

From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Fri, 15 Dec 2017 11:51:22 +0000
Subject: [RFC PATCH 1/2] ASoC: add support of mclk clock providers in
 wm8894 driver
In-Reply-To: <20171214173025.GL9788@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-2-git-send-email-olivier.moysan@st.com>
 <20171214173025.GL9788@sirena.org.uk>
Message-ID: <20171215115122.ckxgoqzlliufz7cm@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 05:30:25PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 05:53:57PM +0100, Olivier Moysan wrote:
> 
> > +	pdata->mclk1 = devm_clk_get(wm8994->dev, "MCLK1");
> > +	if (IS_ERR(pdata->mclk1))
> > +		pdata->mclk1 = NULL;
> 
> These should special case -EPROBE_DEFER so we defer properly if we need
> to (and ideally log an error in case there was a MCLK and we legit ran
> into an error).

We probably want the special case on there being no clock at all
which should silently proceed as this code does and then actual
errors and PROBE_DEFERs can log and fail.

Thanks,
Charles

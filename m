From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 6 Apr 2011 15:40:26 +0530
Subject: [PATCH 5/5] driver core: let dev_set_drvdata return int instead
	of void as it can fail
In-Reply-To: <1302081865-2962-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110301153438.GB15633@suse.de>
	<1302081865-2962-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4D9C3C12.4090408@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 02:54 PM, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I wasn't sure what to return when dev_set_drvdata is called with
> dev=NULL.  I choosed 0, but -EINVAL would be OK for me, too. What do you
> think?

Uwe,

I feel -EINVAL would be more appropriate here.
Return value of 0 would mean drvdata is set properly, which is not the case.

Otherwise, patch series looks fine to me. Please add my reviewed-by for all patches.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh

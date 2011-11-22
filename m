From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 22 Nov 2011 13:58:30 +0530
Subject: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
In-Reply-To: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
References: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4ECB5D2E.1000906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2011 1:55 PM, Linus WALLEIJ wrote:
>  	if (list_empty(&pl022->queue) || !pl022->running) {
> +		if (pl022->busy) {
> +			pm_runtime_put(&pl022->adev->dev);
> +		}

We used to get warnings from checkpatch, for single line code inside {}.
Don't we get them anymore?

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh

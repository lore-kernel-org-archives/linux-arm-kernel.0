From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Mar 2010 11:33:42 +0100
Subject: [PATCH v2] CLKDEV: return from clk_find as soon as we get
	maching clk
In-Reply-To: <1267598907-7095-1-git-send-email-viresh.kumar@st.com>
References: <1267598907-7095-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100303103342.GA7952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Mar 03, 2010 at 12:18:27PM +0530, Viresh KUMAR wrote:
> clk_find function looks for clock with matching dev_id and con_id.
> We should return from clk_find as soon as we get a clock with matching dev_id
> and con_id. This can be done by comparing variable "match" with 3.
> 
> v2:
> 	- remove if (match == 0), check.
> 	- move match==3 in if (match > best) condition
can you take the changes since v1 out of the changelog.  They usually go
...
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
... here.

Does this mean you understood Russell's hint?

Did you test the differences your patch results in for the generated
code?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Mar 2010 20:39:11 +0000
Subject: [PATCH] CLKDEV: return from clk_find as soon as we get maching clk
In-Reply-To: <1267527954-20270-1-git-send-email-viresh.kumar@st.com>
References: <1267527954-20270-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100302203911.GB20675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 02, 2010 at 04:35:54PM +0530, Viresh KUMAR wrote:
> clk_find function looks for clock with matching dev_id and con_id.
> We should return from clk_find as soon as we get a clock with matching dev_id
> and con_id. This can be done by comparing variable "match" with 3.

This breaks the semantics function.  Please look again at the code you're
modifying, and ascertain whether you're changing the semantics of it,
particularly with respect to what happens _in addition_ to returning the
struct clk.

Hint: "return p->clk" is insufficient.

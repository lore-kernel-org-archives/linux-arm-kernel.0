From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 16:09:25 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add	clkdevs
 for given struct clk *
In-Reply-To: <20120416103822.GU24211@n2100.arm.linux.org.uk>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
Message-ID: <4F8BF6DD.5060907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2012 4:08 PM, Russell King - ARM Linux wrote:
> I don't think these checks actually help anyone, especially if the user
> forgets to check the return value (which makes them silent errors.)
> 
> If you're going to abuse the interface by passing a NULL clk_lookup or
> num=0 then you deserve to get a big fat oops to tell you that you messed
> up.  Same for NULL dev_id and con_id above.
> 
> Checking for NULL clk (or IS_ERR(clk)) and returning -ENOMEM does make
> sense as I mentioned in my original proposal (it allows you to pass the
> returned value from clk_register() directly to this function without
> further checking, and you get the right error code.

Got it.

-- 
viresh

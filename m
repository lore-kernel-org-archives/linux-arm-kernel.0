From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 13:28:20 +0530
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424074202.GO24211@n2100.arm.linux.org.uk>
References: <20120424070426.GA24089@lunn.ch> <4F9650B3.9030406@st.com>
 <20120424072653.GB24089@lunn.ch>
 <20120424074202.GO24211@n2100.arm.linux.org.uk>
Message-ID: <4F965D1C.2010203@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 1:12 PM, Russell King - ARM Linux wrote:
> If you don't have the clk API configured, you have no clocks to control.
> So, why not make clk_get() return NULL, and make the rest of the API
> calls do nothing?  That's what you'll end up codifying in the drivers
> anyway.

Ok. We can return NULL from calls that return clk *. What about other
routines that return integers. Like, clk_enable().

Is returning 0 correct? Which would mean we were able to enable clk, but
actually we haven't.

-- 
viresh

From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 16:13:45 +0530
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120413102036.GJ24211@n2100.arm.linux.org.uk>
References: <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com> <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
 <20120413092615.GH24211@n2100.arm.linux.org.uk> <4F87F188.60603@st.com>
 <20120413093606.GI24211@n2100.arm.linux.org.uk> <4F87F9C3.2010802@st.com>
 <20120413102036.GJ24211@n2100.arm.linux.org.uk>
Message-ID: <4F880361.9080708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 3:50 PM, Russell King - ARM Linux wrote:
> So you're going to have something around 4-5 lines of arguments per
> function call to use this function.  That's not elegant, that's not
> easy to use, that's not nice.  And I doubt that it really solves any
> code space concern because the compiler will have to store pointers
> and values somewhere, and shuffle those into registers and onto the
> stack for every function call using additional code to do that.

But it is still the same with the current implementation. Right now
also we have too many arguments. Even if we do clkdev_alloc() in
platform files.

> I really don't get why you think this is an improvement.

Only improvement is simplicity at the end of machine clock.c files, that
don't need to do clkdev_alloc() for every clock they clk_lookups.

I didn't liked this long of argument list, but couldn't think of
something better, that makes machine clock code easy. :(

-- 
viresh

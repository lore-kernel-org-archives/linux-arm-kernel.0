From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 30 Apr 2012 13:38:35 +0530
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <20120428095222.GP24211@n2100.arm.linux.org.uk>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
 <20120426074746.GD24211@n2100.arm.linux.org.uk> <4F992369.2020308@st.com>
 <20120428095222.GP24211@n2100.arm.linux.org.uk>
Message-ID: <4F9E4883.2060303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/28/2012 3:22 PM, Russell King - ARM Linux wrote:
> I don't like that macro in there, I think it's unnecessary.  What about
> the below, which I've built here and it builds fine.

Even i didn't liked it too.

> As for va_start(ap, dev_fmt) when dev_fmt is NULL, that's perfectly fine
> - the requirement for va_start() is that it is called with the argument
> preceding the variable list of function arguments signified by '...'.
> That's still true when dev_fmt is NULL (hint: the compiler doesn't know
> at build time if dev_fmt was passed into this function as a NULL pointer
> or a real pointer, so it's going to generate code which works for non-NULL
> pointers.  If the pointer _is_ NULL, then we don't touch 'ap' other than
> its initialization and finalization via the standard functions.)

And i did implement it, because i didn't knew this. :)

> Plus, I've added commentry to these two new functions because there's
> an important point that needs to be conveyed (the fact that they do the
> error handling for clk_register()).

That good.

When are you pushing this to linux-next? I need it urgently so that SPEAr
patches can be pushed by Arnd.

-- 
viresh

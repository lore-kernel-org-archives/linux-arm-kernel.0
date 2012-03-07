From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 7 Mar 2012 04:37:12 -0800
Subject: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
In-Reply-To: <20120307122732.GS17370@n2100.arm.linux.org.uk>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
 <20120307111833.GQ17370@n2100.arm.linux.org.uk>
 <CAOh2x==z1Mhc5k7qSJ++ix+TPaWcUfCKNdyfnzzZwiGO59Sudg@mail.gmail.com>
 <20120307122732.GS17370@n2100.arm.linux.org.uk>
Message-ID: <CAOh2x=mCMdSVAGXtEg3=P8aJxc5kmk-UqDYeKLGnQZpUYu0DrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> Drivers have no business interpreting anything but an IS_ERR() return from
> clk_get() as invalid.  Everything else is the CLK APIs business, not the
> driver's business.  So, to start using NULL as a special case is wrong.

But driver isn't comparing return value of clk_get with NULL (that would have
been wrong) or interpreting its return value in a wrong way.

Instead it is using the same pointer/variable to check if clk_* APIs are
supported or not by making it NULL. And that's a driver convention.
I still believe it is fine.

Thanks for your quick comments.

--
viresh

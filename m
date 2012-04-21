From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Apr 2012 13:40:43 +0100
Subject: [PATCH 03/13] clk: CLK_PREPARE must depend on HAVE_CLK
In-Reply-To: <ffaffaeeb39c5b7741ee8e616682d51d213fa512.1335008617.git.viresh.kumar@st.com>
References: <cover.1335008617.git.viresh.kumar@st.com>
 <ffaffaeeb39c5b7741ee8e616682d51d213fa512.1335008617.git.viresh.kumar@st.com>
Message-ID: <20120421124043.GG24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 05:17:30PM +0530, Viresh Kumar wrote:
> CLK_PREPARE must have dependency on HAVE_CLK. Add it.

No - its possible to have HAVE_CLK_PREPARE selected independently of
HAVE_CLK.  Why do we want to end up having to add conditionals all
over the place for 'select HAVE_CLK_PREPARE' ?

The only time HAVE_CLK_PREPARE gets used is in a header file, where you're
already making it conditional on HAVE_CLK.  Nothing else should know about
HAVE_CLK_PREPARE.

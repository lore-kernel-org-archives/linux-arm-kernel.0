From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 15 Apr 2013 14:30:38 +0100
Subject: [PATCH] clk: add DT test clock consumer driver
In-Reply-To: <1363439376-21294-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1363439376-21294-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130415133038.2A7723E0AA8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Mar 2013 14:09:36 +0100, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> This driver adds a DT test clock consumer that exposes debugfs files to
> enable/disable and set/get rate of the attached programmable clock.
> During development of a i2c-attached clock generator I found it useful
> to debug the clock generator's internal pll settings by enforcing clock
> rates through debugfs.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Rather that using a DT binding to enable this, would it not be better to
have the debug interface bound entirely at runtime, and be able to
attach to pretty much any clock. It is less usable if it requires
modifying the dtb to use a debug feature.

g.

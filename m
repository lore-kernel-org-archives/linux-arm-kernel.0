From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Nov 2012 09:34:45 +0000
Subject: [RFC/PATCH 0/3] CLK: add more devm_* APIs
In-Reply-To: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <20121120093445.GL3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 01:22:16AM -0800, Dmitry Torokhov wrote:
> Hi,
> 
> When looking at recent driver conversions to managed resources (devm_*) there
> is no devm_clk_prepare() and similar functions, which forces mixing of 2
> resource management styles (managed/classic) in the same driver, which is not
> great.
> 
> This patch series adds more devm_* managed APIs to the CLK subsystem so that
> driver conversions can be "pure".

So, how do you ensure the correct ordering between clk_unprepare() and
clk_put(), or even clk_disable() and clk_unprepare() ?  I see nothing
here which makes any guarantees as to the ordering of those operations
upon cleanup.

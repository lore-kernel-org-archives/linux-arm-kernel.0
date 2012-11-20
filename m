From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Nov 2012 09:35:23 +0000
Subject: [PATCH 2/3] CLK: uninline clk_prepare_enable() and
 clk_disable_unprepare()
In-Reply-To: <1353403339-11679-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-3-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <20121120093522.GM3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 01:22:18AM -0800, Dmitry Torokhov wrote:
> We'll need to invoke clk_disable_unprepare() via a pointer in our devm_*
> conversion so let's uninline the pair.

Again, what about stuff not using drivers/clk/clk.c ?

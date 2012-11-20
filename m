From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Nov 2012 09:32:42 +0000
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <20121120093242.GK3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 01:22:17AM -0800, Dmitry Torokhov wrote:
> We'll need to invoke clk_unprepare() via a pointer in our devm_*
> conversion so let's uninline the pair.

NAK.  This breaks non-common clock using implementations.

Why do you need to call this function via a pointer?  That sounds absurd.

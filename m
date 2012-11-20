From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 20 Nov 2012 01:57:57 -0800
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121120093242.GK3290@n2100.arm.linux.org.uk>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <20121120093242.GK3290@n2100.arm.linux.org.uk>
Message-ID: <20121120095757.GB11732@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:32:42AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 20, 2012 at 01:22:17AM -0800, Dmitry Torokhov wrote:
> > We'll need to invoke clk_unprepare() via a pointer in our devm_*
> > conversion so let's uninline the pair.
> 
> NAK.  This breaks non-common clock using implementations.

As Viresh mentioned I provided stubs for case when we do not have
CONFIG_HAVE_CLK, so I am not sure how I'll break these platforms, but I
am certainly open for suggestions.
 
> 
> Why do you need to call this function via a pointer?  That sounds absurd.

devres framework takes and stores a pointer to a "destructor" which will
be used later.

Thanks.

-- 
Dmitry

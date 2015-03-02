From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 23:54:35 +0000
Subject: [PATCH 01/10] media: omap3isp: remove unused clkdev
In-Reply-To: <20150302225336.GV6539@valkosipuli.retiisi.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnC-0001JU-CX@rmk-PC.arm.linux.org.uk>
 <118780170.u6ZO5zJrEk@avalon>
 <20150302225336.GV6539@valkosipuli.retiisi.org.uk>
Message-ID: <20150302235435.GF29584@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Combining replies...)

On Tue, Mar 03, 2015 at 12:53:37AM +0200, Sakari Ailus wrote:
> Hi Laurent and Russell,
> 
> On Tue, Mar 03, 2015 at 12:33:44AM +0200, Laurent Pinchart wrote:
> > Sakari, does it conflict with the omap3isp DT support ? If so, how would you 
> > prefer to resolve the conflict ? Russell, would it be fine to merge this 
> > through Mauro's tree ?

As other changes will depend on this, I'd prefer not to.  The whole
"make clk_get() return a unique struct clk" wasn't well tested, and
several places broke - and currently clk_add_alias() is broken as a
result of that.

I'm trying to get to the longer term solution, where clkdev internally
uses a struct clk_hw pointer rather than a struct clk pointer, and I
want to clean stuff up first.

If omap3isp needs to keep this code, then so be it - I'll come up with
a different patch improving its use of clkdev instead.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

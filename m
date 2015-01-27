From: balbi@ti.com (Felipe Balbi)
Date: Tue, 27 Jan 2015 11:18:43 -0600
Subject: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
In-Reply-To: <20150127171532.GC14878@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
 <20150126165640.GA10679@saruman.tx.rr.com>
 <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com>
 <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com>
 <20150127171532.GC14878@saruman.tx.rr.com>
Message-ID: <20150127171843.GD14878@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:15:32AM -0600, Felipe Balbi wrote:
> On Tue, Jan 27, 2015 at 05:12:05PM +0000, Paul Walmsley wrote:
> > Hi
> > 
> > On Tue, 27 Jan 2015, Felipe Balbi wrote:
> > 
> > > On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> > > > On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > > >
> > > > > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?
> > > > 
> > > > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> > > > read as 0x 12510f00 which would translate into:
> > > > 
> > > > - module disabled
> > > > - all opt clocks are on
> > > > - module is transitioning
> > > > - module in standby
> > > > - clkA as TPIU and STM trace clock
> > > > - all dividers set to 2
> > > 
> > > just fyi, checking with HW folks, this might be a new bug, unless
> > > debugss needs something special.
> > 
> > If that happens on DEBUGSS disable, it's probably the same issue as on 
> > AM33xx:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg320801.html
> > http://www.spinics.net/lists/arm-kernel/msg321930.html
> > http://www.spinics.net/lists/arm-kernel/msg329151.html
> > 
> > Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?
> 
> I'll try it out in a bit...

nope, same thing.

[   27.633235] omap_hwmod: debugss: _wait_target_disable failed

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/7d2c6293/attachment.sig>

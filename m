From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 11 Sep 2012 22:35:38 +0200
Subject: [PATCH] cpufreq: add helper function cpufreq_set_target()
In-Reply-To: <20120911013405.GB13721@S2101-09.ap.freescale.net>
References: <1346981599-28081-1-git-send-email-shawn.guo@linaro.org>
 <201209102222.45165.rjw@sisk.pl>
 <20120911013405.GB13721@S2101-09.ap.freescale.net>
Message-ID: <201209112235.38246.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 11, 2012, Shawn Guo wrote:
> On Mon, Sep 10, 2012 at 10:22:44PM +0200, Rafael J. Wysocki wrote:
> > Hmm.  Who's going to use the cpufreq-cpu0 driver, then?  Is OMAP going to be
> > the only user?
> > 
> Any platform that supports device tree (DT) will be able to use the
> driver.  Right now, I have seen imx6q, AM35xx and highbank start using
> the driver.

OK, that would be sufficient.

> > I'm concerned about the copy-pasting, but if that copy-pasting is going to
> > go away when you move OMAP to the new driver, then I agree that adding more
> > complexity just to avoid it is probably not a good idea.
> > 
> > What's the planned time frame for the OMAP conversion?
> > 
> That depends on when OMAP gets fully converted to DT.  OMAP is in the
> middle of the DT transition right now.  There are in-tree users of
> omap-cpufreq driver that does not support DT (board files).  Before
> the DT conversion is fully done (all those non-DT board files gets
> removed), the omap-cpufreq driver still needs to be for a while.

I see.

Well, then I'll push the driver to Linus for v3.7 as is and we'll see who
and when starts to use it.

Thanks,
Rafael

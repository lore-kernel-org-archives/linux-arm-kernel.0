From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 12 Jul 2013 16:26:43 +0800
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <201307120604.43642.marex@denx.de>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307111957.19537.marex@denx.de>
 <20130712031200.GB14793@nchen-desktop>
 <201307120604.43642.marex@denx.de>
Message-ID: <20130712082642.GB16202@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 06:04:43AM +0200, Marek Vasut wrote:
> Hi Peter,
> 
> > On Thu, Jul 11, 2013 at 07:57:19PM +0200, Marek Vasut wrote:
> > > Hi Peter,
> > > 
> > > > This patchset adds tested otg id switch function and
> > > > vbus connect and disconnect detection for chipidea driver.
> > > > And fix kinds of bugs found at chipidea drivers after enabling
> > > > id and vbus detection.
> > > > 
> > > > This patch is fully tested at imx6 sabresd platform.
> > > > My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
> > > > 
> > > > Changes for v12:
> > > > - Rebased greg's usb-next tree (3.10.0-rc7+)
> > > > - Split more small patches for single function and fix.
> > > 
> > > I tested the patchset. Here are the results:
> > > 
> > > - VBUS switching
> > > 
> > > I'm no longer getting any ID interrupts at all when I apply the patch
> > > below. The board stays in HOST mode all the time. If I configure it as
> > > peripheral, it works as peripheral. Note with [1], I was able to switch
> > > from Peripheral->Host , not the other way around.
> > 
> > Thanks for your testing. But first, can you have me check
> > if your ID wakeup is enabled?
> 
> ID wakeup? How do I check?
> 

See otgsc at controller register, the ID wakeup enable is bit 24.

-- 

Best Regards,
Peter Chen

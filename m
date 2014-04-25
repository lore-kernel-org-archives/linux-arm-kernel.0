From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Apr 2014 16:00:36 -0500
Subject: [PATCH] power: twl4030_charger: clear IRQs after handling them
In-Reply-To: <535ACC62.102@ti.com>
References: <1397661299-31342-1-git-send-email-balbi@ti.com>
 <20140416163526.GA3049@atomide.com> <535ACC62.102@ti.com>
Message-ID: <20140425210036.GO29632@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 03:58:10PM -0500, Nishanth Menon wrote:
> On 04/16/2014 11:35 AM, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [140416 08:18]:
> >> TRM says we *must* write 1 to each bit we're handling
> >> in order to clear the IRQ status and bring IRQ line
> >> low. This patch implements that.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >>
> >> Russell, I don't have HW to test, but this should
> >> solve the problem you saw when not using battery
> >> with Zoom board. Let me know if it doesn't.
> > 
> > BTW, looks like we're enabling BCI automatically in twl4030.dtsi
> > while the legacy booting does not have TWL_COMMON_PDATA_BCI
> > enabled for LDP. Anyways, for LDP BCI should be enabled for
> > sure, that's the only way to power at least the earlier LDP
> > revisions.
> > 
> I picked up https://patchwork.kernel.org/patch/4002371/ for testing.
> 
> Unfortunately, it does not seem to work in my tests:

alright, I'll have a look after I get this other issue out of the way.
Probably not until next week.

> This patch should probably also acknowledge that Russell reported this
> issue.

sure I can add that, although it doesn't solve anything as it is ...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/57d54cb0/attachment.sig>

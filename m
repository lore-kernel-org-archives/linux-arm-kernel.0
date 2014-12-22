From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Dec 2014 10:43:17 -0600
Subject: [RESEND PATCH] usb: gadget: at91_udc: move prepare clk into
 process context
In-Reply-To: <20141219141831.GB2620@charon>
References: <1416411447-31112-1-git-send-email-nicolas.ferre@atmel.com>
 <20141120195049.GF23217@saruman> <20141219135123.GA2620@charon>
 <54942FDC.8030404@raritan.com> <5494314F.1030002@atmel.com>
 <20141219141831.GB2620@charon>
Message-ID: <20141222164317.GJ12815@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 19, 2014 at 02:18:31PM +0000, Luis Henriques wrote:
> On Fri, Dec 19, 2014 at 03:08:15PM +0100, Nicolas Ferre wrote:
> > Le 19/12/2014 15:02, Ronald Wahl a ?crit :
> > > On 19.12.2014 14:51, Luis Henriques wrote:
> > >> Hi Felipe,
> > >>
> > >> On Thu, Nov 20, 2014 at 01:50:49PM -0600, Felipe Balbi wrote:
> > >>> On Wed, Nov 19, 2014 at 04:37:27PM +0100, Nicolas Ferre wrote:
> > >>>> From: Ronald Wahl <ronald.wahl@raritan.com>
> > >>>>
> > >>>> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b (usb: gadget: at91_udc:
> > >>>> prepare clk before calling enable) added clock preparation in interrupt
> > >>>> context. This is not allowed as it might sleep. Also setting the clock
> > >>>> rate is unsafe to call from there for the same reason. Move clock
> > >>>> preparation and setting clock rate into process context (at91udc_probe).
> > >>>>
> > >>>> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> > >>>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > >>>> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > >>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > >>>> Cc: Felipe Balbi <balbi@ti.com>
> > >>>> Cc: <stable@vger.kernel.org> # v3.17+
> > >>>> ---
> > >>>> Hi Felipe,
> > >>>>
> > >>>> I forgot to answer you on this patch. So I resend it now with the proper
> > >>>> "stable" tag. You can also queue it during this -rc phase if you feel it is
> > >>>> still possible.
> > >>>
> > >>> I think it's late for v3.18, so it'll go on v3.19 and get backported to
> > >>> 3.17 and 3.18. Sorry :-s
> > >>>
> > >>
> > >> Although this commit (b2ba27a5c56f "usb: gadget: at91_udc: move
> > >> prepare clk into process context") is tagged for stable v3.17+, it
> > >> seems like it could be applied to earlier kernels.
> > >>
> > >> 3.16, 3.13 and 3.12 seem to be affected by the same issue (and they
> > >> all include commit 7628083227b6 "usb: gadget: at91_udc: prepare clk
> > >> before calling enable").  Is there any reason for not applying it in
> > >> these trees?
> > > 
> > > Not to forget 3.14 (LTS) which was the branch where I primarily found 
> > > the issue...
> >
> 
> Yes, of course!  Sorry.
> 
> > Well it's maybe an issue with the re-naming of the directory to
> > drivers/usb/gadget/udc/ introduced by patch:
> > 90fccb529d24 (usb: gadget: Gadget directory cleanup - group UDC drivers)
> > 
> > The patch doesn't apply out of the box but it surely can be applied in
> > those earlier kernels.
> > 
> >
> 
> Right, the file was renamed but the backport seems to be trivial.
> Thanks for confirming.

can someone resend the patch with the correct Cc: stable tag so I can
apply it ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/4749da53/attachment.sig>

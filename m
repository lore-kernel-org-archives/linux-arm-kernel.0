From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 7 Dec 2011 21:22:03 +0100
Subject: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
In-Reply-To: <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
References: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
 <4ECB5D2E.1000906@st.com>
 <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
Message-ID: <20111207202203.GA3744@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Nov 22, 2011 at 10:28:44AM +0100, Linus Walleij wrote:
> On Tue, Nov 22, 2011 at 9:28 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> > On 11/22/2011 1:55 PM, Linus WALLEIJ wrote:
> >> ? ? ? if (list_empty(&pl022->queue) || !pl022->running) {
> >> + ? ? ? ? ? ? if (pl022->busy) {
> >> + ? ? ? ? ? ? ? ? ? ? pm_runtime_put(&pl022->adev->dev);
> >> + ? ? ? ? ? ? }
> >
> > We used to get warnings from checkpatch, for single line code inside {}.
> > Don't we get them anymore?
> 
> It's driven by heuristics, I think it only warns on the first level since
> elsewhere you may want braces for readability.
> 
> But I'll take it out when I add you Reviewed-by...

Does that imply you will send out a V3 of this series somewhen and I
don't need to add this right now to the for-grant branch I am currently
preparing?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111207/b856cd69/attachment.sig>

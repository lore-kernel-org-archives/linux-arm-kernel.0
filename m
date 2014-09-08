From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 08 Sep 2014 23:08:15 +0200
Subject: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain
 look-up
In-Reply-To: <5191943.peyCs6gZVs@vostro.rjw.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFovLmajQORVT1Mf01J5L7O73JNDFz=gr3fXKvF5xZGCdQ@mail.gmail.com>
 <5191943.peyCs6gZVs@vostro.rjw.lan>
Message-ID: <3105400.7vSnq2rA6s@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 08, 2014 11:04:23 PM Rafael J. Wysocki wrote:
> On Monday, September 08, 2014 09:26:20 AM Ulf Hansson wrote:
> > On 8 September 2014 00:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Thursday, September 04, 2014 03:52:29 PM Ulf Hansson wrote:
> > >> From: Tomasz Figa <t.figa@samsung.com>
> > >>
> > >> This patch introduces generic code to perform PM domain look-up using
> > >> device tree and automatically bind devices to their PM domains.
> > >>
> > >> Generic device tree bindings are introduced to specify PM domains of
> > >> devices in their device tree nodes.
> > >>
> > >> Backwards compatibility with legacy Samsung-specific PM domain bindings
> > >> is provided, but for now the new code is not compiled when
> > >> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code.
> > >> This will change as soon as the Exynos PM domain code gets converted to
> > >> use the generic framework in further patch.
> > >>
> > >> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >> [Ulf:Added attach|detach functions, fixed review comments]
> > >> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > >
> > > However, for this one (and consequently the rest) I need an ACK from the
> > > people who maintain the bindings.
> > 
> > These DT bindings have been discussed between Tomasz and devicetree
> > maintainers previously. So I think there are fine.
> > 
> > Also, when browsing the mail-archives, I found an ack from Rob Herrring:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237989.html
> > 
> > I realize that I didn't put the DT maintainers on the to-line when
> > posting this patch, but just the devicetree list. I have now included
> > them on this reply, but maybe I should repost instead. What do you
> > think? Are you happy with the above ack from Rob?
> 
> That should be sufficient, but I wonder why you didn't add it to the patch
> to start with?

BTW, I get bounces from t.figa at samsung.com, so I won't apply the patch with
that as the "From" field.  And the s-o-b from a bouncing address is worthless
too.

Rafael

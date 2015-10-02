From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 12:45:28 -0700
Subject: [PATCH v4 0/8] i.MX early debug UART clock fixes
In-Reply-To: <1443108993.8476.10.camel@pengutronix.de>
References: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
 <20150924152016.GV3529@tiger>
 <1443108993.8476.10.camel@pengutronix.de>
Message-ID: <20151002194528.GX12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24, Lucas Stach wrote:
> Am Donnerstag, den 24.09.2015, 08:20 -0700 schrieb Shawn Guo:
> > On Mon, Sep 21, 2015 at 06:53:56PM +0200, Lucas Stach wrote:
> > > This series fixes a long standing interaction issue between the
> > > kernels early debug facilities and the i.MX clock drivers.
> > 
> > This is fixing some issue but not regression.  As the change basically
> > has influence on all i.MX platforms, my take is that we should get them
> > into linux-next for extensive testing and queue for 4.4.  Agree?
> > 
> Absolutely, this fixes a bug which should mostly hit developers running
> with earlyprintk or earlycon, so it's definitely not fixes material.
> 
> Please queue it up for 4.4.

Patches look mostly ok to me, but this certainly feels like some
generic problem that we should handle in the core. Perhaps it
would make sense to move this over to using the handoff mechanism
Mike is working on, where we keep the clock on until a consumer
grabs a reference to the clock?

So I'm not opposed to merging this for 4.4, but I'd like to see
it become a generic solution sometime soon, instead of staying as
a one-off fix for imx platforms.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

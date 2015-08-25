From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 25 Aug 2015 14:56:09 +0200
Subject: [PATCH] ARM: enable imprecise aborts during early kernel startup
In-Reply-To: <20150825124042.GR7557@n2100.arm.linux.org.uk>
References: <1440501845-25723-1-git-send-email-l.stach@pengutronix.de>
 <20150825124042.GR7557@n2100.arm.linux.org.uk>
Message-ID: <1440507369.3066.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 25.08.2015, 13:40 +0100 schrieb Russell King - ARM
Linux:
> On Tue, Aug 25, 2015 at 01:24:05PM +0200, Lucas Stach wrote:
> > From: Fabrice Gasnier <fabrice.gasnier@st.com>
> > 
> > This patch adds imprecise abort enable/disable macros and uses them to
> > enable imprecise aborts early when starting the kernel.
> > 
> > This helps in tracking down the real cause for such imprecise abort, as
> > they are handled as soon as they occur. Until now those aborts would
> > only be enabled when entering the userspace and as a consequence crash
> > the first userspace process if any abort had been raised during kernel
> > startup.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Looks fine to me.  I think as we know Keystone2 definitely has issues
> with this, I'd like to delay it to the v4.4 merge window, but please
> consider putting it in the patch system anyway so it doesn't get
> forgotten about.  I'll queue it after 4.3-rc1 is out.
> 
That sounds sensible.

Patch is in the system as 8422/1.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

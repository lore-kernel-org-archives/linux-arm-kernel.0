From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 26 Sep 2012 13:19:46 +0100
Subject: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
 suspend/resume
In-Reply-To: <CACRpkdampxUw0=NO6cs679C-r0_AnPEaTYVc+GppRkKGn32p-w@mail.gmail.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
 <1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
 <CACRpkdampxUw0=NO6cs679C-r0_AnPEaTYVc+GppRkKGn32p-w@mail.gmail.com>
Message-ID: <20120926121946.GO4428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 02:17:36PM +0200, Linus Walleij wrote:
> On Wed, Sep 26, 2012 at 1:24 PM, Vipul Kumar Samar

> > SPI functional clock must be disalble/enable in non RTPM suspend/resume
> > hooks. Currently it is only done for RTPM cases.

> > This patch add support to disable/enbale clock for conventional
> > suspend/resume calls.

> Cross dependency between runtime suspend/resume and
> common suspend/resume. Oh the horror ...

This should be fine, we runtime resume before we suspend.

> The semantics between runtime suspend/resume and
> ordinary suspend/resume are unclear to me, it seems like
> this is all up to the drivers and busses to figure out. Like
> you weren't supposed to use both at the same time.

This was clarified at some point relatively recently with the above
(which is essentially the same as the solution you describe).

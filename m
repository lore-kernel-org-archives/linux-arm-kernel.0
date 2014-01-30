From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jan 2014 19:39:08 +0100
Subject: [PATCH 1/4] ARM: STi: add stid127 soc support
In-Reply-To: <201401301935.16463.arnd@arndb.de>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <1391093744-19905-2-git-send-email-patrice.chotard@st.com>
 <201401301935.16463.arnd@arndb.de>
Message-ID: <201401301939.08302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 January 2014, Arnd Bergmann wrote:
> On Thursday 30 January 2014, Patrice CHOTARD wrote:
> > From: Alexandre TORGUE <alexandre.torgue@st.com>
> > 
> > This patch adds support to STiD127 SoC.
> > The main adaptation is the L2 cache way size compare to STiH41x SoCs.
> > 
> > Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
> > Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> > ---
> >  arch/arm/mach-sti/board-dt.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Wouldn't it be better to read this value from the l2 cache
> controller node? I'd assume there might be more SoCs that
> will need a similar change, so it's better to come up with
> a solution that doesn't involve changing the kernel every
> time.

Actually reading the code in this file shows that the L2 cache
initialization is the only nonstandard thing in there. We should
really find a way to get rid of the entire function.

Sorry if I missed the initial review, but can you explain
why this is needed to start with?

	Arnd

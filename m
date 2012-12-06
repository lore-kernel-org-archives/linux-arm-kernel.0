From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Dec 2012 10:47:10 +0000
Subject: [PATCH] nommu: Enable the strict alignment (CR_A) bit only if
 ARCH < v6
In-Reply-To: <20121205195134.GD3384@pengutronix.de>
References: <1354187042-28568-1-git-send-email-armando.visconti@st.com>
 <50BCD6DB.2030200@st.com>
 <20121203172553.GC14363@n2100.arm.linux.org.uk>
 <20121203174617.GL20074@mudshark.cambridge.arm.com>
 <20121205195134.GD3384@pengutronix.de>
Message-ID: <20121206104710.GB749@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 07:51:34PM +0000, Uwe Kleine-K?nig wrote:
> Hello,

Hi Uwe,

> On Mon, Dec 03, 2012 at 05:46:17PM +0000, Will Deacon wrote:
> > I think Uwe also requires some of the stuff there for his M3 port.
> I didn't check more context than available in the patch and I also
> didn't double-check the M3-docs, but AFAIK the M3 doesn't have a cp15
> and I noopt this code out.

I was thinking more about the word-at-a-time stuff, which relies on
efficient unaligned access for the dcache accesses.

Will

From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Fri, 15 Dec 2017 11:46:06 +0000
Subject: [RFC PATCH 2/2] ASoC: select sysclk clock from mlck clock
 provider in wm8994 driver
In-Reply-To: <20171214173624.GM9788@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
Message-ID: <20171215114606.6wxw2m5rykmb7ak2@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 05:36:24PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 05:53:58PM +0100, Olivier Moysan wrote:
> > When defined in device tree, MCLK1 and MCLK2 are used
> > as sysclk for aif1 and aif2 interfaces respectively.
> 
> That's not a valid assumption as far as I remember?  The AIFs can use
> either MCLK depending on the system configuration I think.
> 

Indeed yes the code added here is literally just above the code
that selects that, it should be fairly simple to update the patch
to take this into account.

Thanks,
Charles

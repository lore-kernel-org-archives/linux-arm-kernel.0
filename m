From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 Aug 2016 16:24:32 +0200
Subject: [PATCH 2/8] arm: orion5x: Add clk support for mv88f5181
In-Reply-To: <alpine.DEB.2.11.1608261256170.19980@marmot.wormnet.eu>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-3-git-send-email-jm@lentin.co.uk>
 <20160826113437.GA12692@Red>
 <alpine.DEB.2.11.1608261256170.19980@marmot.wormnet.eu>
Message-ID: <20160826142432.GH25046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 01:24:18PM +0100, Jamie Lentin wrote:
> On Fri, 26 Aug 2016, LABBE Corentin wrote:
> 
> >Hello
> >
> >I have some minor comments below
> >
> >[...]
> >>+
> >>+static u32 __init mv88f5181_get_tclk_freq(void __iomem *sar)
> >>+{
> >>+	u32 opt = (readl(sar) >> SAR_MV88F5181_TCLK_FREQ) &
> >>+		SAR_MV88F5181_TCLK_FREQ_MASK;
> >
> >Checkpatch complain about a missing blank line after declaration.
> >And spliting the read and the & operation will prevent this line breaking
> 
> It isn't here, although I'm not arguing the line is missing. Is
> there an extra switch I'm missing?

I agree it is a false positive.

Probably the best action is to report it to the checkpatch people.

> >>+	if (opt == 0)
> >>+		return 133333333;
> >>+	else if (opt == 1)
> >>+		return 150000000;
> >>+	else if (opt == 2)
> >>+		return 166666667;
> >>+	else
> >>+		return 0;
> >>+}
> >
> >Why not using a switch here ?
> 
> If you look at this in context[0], this is one of several
> code-as-config declarations, none of which use a switch. IMO it's
> more useful to make the similarity as obvious as possible if this is
> ever refactored.

Agreed. Please leave it as is, and if anybody does care about this,
they can submit a followup patch refactoring all instances.
 
	Andrew

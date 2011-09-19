From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Sep 2011 14:49:48 -0600
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <4E76615C.3000005@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com> <4E71F978.6020402@gmail.com>
	<4E72030F.1090300@ti.com> <4E722B2D.4050307@gmail.com>
	<4E76615C.3000005@gmail.com>
Message-ID: <20110919204948.GB30517@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2011 at 04:23:40PM -0500, Rob Herring wrote:
> On 09/15/2011 11:43 AM, Rob Herring wrote:
> > I see 2 options (besides leaving it as is):
> > 
> > - Revert back to my previous binding where PPIs are a sub-node and a
> > different interrupt parent.
> > 
> > - Use the current binding, but allow SPIs to start at 0. We can still
> > distinguish PPIs and SPIs by the cpu mask cell. A cpu mask of 0 is a
> > SPI. If there was ever a reason to have a cpu mask for an SPI, you would
> > not be able to with this scheme.
> > 
> > Either way you will still have the above issue with the cell size changing.
> > 
> 
> I was headed down the path of implementing the 2nd option above, but had
> a dilemma. What would be the numbering base for PPIs in this case?
> Should it be 0 in the DT as proposed for SPIs or does it stay at 16?
> Numbering PPIs at 0 will just cause confusion as will numbering
> differently from SPIs. There is absolutely no mention of SPI0 or SPIx
> numbering in the GIC spec. All interrupt number references refer to the
> absolute interrupt ID, not a relative number based on the type.

Hi Rob,

See here[1] and [2] (figures 3.14 and 3.16).  In both cases, there is
clearly a reference to PPI numbering from 0-15 and SPI numbering from
0-987 (as inputs to the distributor block).

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0416b/Bhacbfdb.html
[2] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0416b/Cihebcbg.html

g.

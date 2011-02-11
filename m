From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 10 Feb 2011 23:31:00 -0800
Subject: [PATCH V3 1/1] ST SPEAr: PCIE gadget suppport
In-Reply-To: <4D54E39C.6070306@st.com>
References: <1296742149-18102-1-git-send-email-pratyush.anand@st.com>
	<20110209152926.0126ac97.akpm@linux-foundation.org>
	<4D53B4C1.5080804@st.com>
	<20110210125256.609a1143.akpm@linux-foundation.org>
	<4D54E39C.6070306@st.com>
Message-ID: <20110210233100.e12e8f6a.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Feb 2011 12:52:04 +0530 pratyush <pratyush.anand@st.com> wrote:

> >>> This interface implies that there will only ever be one device in the
> >>> machine, yes?  Seems a bit short-sighted?
> >>>
> >>
> >> This device supports only one BAR in EP mode.
> > 
> > I don't understand that.
> > 
> > What happens if someone builds a computer with three of these devices
> > in it?
> > 
> 
> I understood it. I will modify the code to work with multiple instances of
> pcie device.

I don't think you need to go that far, unless you see a significant
likelihood think that such a computer might be created one day.  This
depends on how hard and risky such a change is, of course.

But the current driver's userspace interface should at least
anticipate the possibility, so you aren't trapped into a weird or
non-back-compatible interface in the future.

So for now you might choose to do something as simple as renaming
/config/pcie-gadget to /config/pcie-gadget0 and leave it at that.

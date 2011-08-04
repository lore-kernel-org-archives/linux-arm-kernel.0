From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 11:02:42 +0530
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case
	of error interrupt
In-Reply-To: <4E3A342E.5080503@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
	<1311941799.1536.532.camel@vkoul-udesk3>
	<CAOh2x==_g+JQzTizgVTdH8Dyg_5+KpyYm+G_Ddu5mO15N6n-tw@mail.gmail.com>
	<1312431918.1536.559.camel@vkoul-udesk3>  <4E3A342E.5080503@st.com>
Message-ID: <1312435962.1536.566.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-04 at 11:24 +0530, viresh kumar wrote:
> On 08/04/2011 09:55 AM, Koul, Vinod wrote:
> > Yes that's the whole point, today callback mechanism doesn't tell the
> > _status_ of the transfer (which if we need change can be discussed as
> > well), but to counter argue I have never been able to generate the error
> > interrupt, are you able to do on your controller?
> 
> Yes, if we supply unaligned address, with access width as word, then it gives
> error interrupt.
> 
> Regarding your point of updating callback for reporting errors,
> I think it is required and should be a common issue.
Okay till now no one has asked for it. We can add to callback arguments
either a bool to indicate what is the transfer status or usual error
code to also indicate what type of failure.
I would prefer latter, if there is consensus on this, we can go thru
with this approach, Dan your comments?

-- 
~Vinod

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Apr 2012 10:36:06 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <4F87F188.60603@st.com>
References: <20120411094704.GY24211@n2100.arm.linux.org.uk>
 <4F879E9D.2090502@st.com>
 <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com> <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
 <20120413092615.GH24211@n2100.arm.linux.org.uk> <4F87F188.60603@st.com>
Message-ID: <20120413093606.GI24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 02:57:36PM +0530, Viresh Kumar wrote:
> On 4/13/2012 2:56 PM, Russell King - ARM Linux wrote:
> > What's wrong with the struct clk returned from clk_register() - why
> > not do this as a two-step process?
> 
> Code duplication on all platforms for creating these lookups.
> 
> > Especially as you may want to
> > associate a single clock with more than one clk_lookup.
> 
> Can still be done, as we are still getting clk pointer back.

You're not convincing me that you're approach here is correct, and
I really doubt that this will have any effect at saving lines of code -
your argument list is soo long that you'll have to wrap it onto several
lines.

So I don't buy the 'code duplication' argument here - I think that's a
red herring, and I think you're better off making interfaces which are
simpler to use.

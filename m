From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 12:35:23 +0530
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424070426.GA24089@lunn.ch>
References: <20120424070426.GA24089@lunn.ch>
Message-ID: <4F9650B3.9030406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:34 PM, Andrew Lunn wrote:
> I don't think this change is correct. With the old semantics, it was:

Sorry. :(

> If we have CLK support, we expect there to be a clock for sata_mv, and
> if there is no such clock, output a notice message, something is
> probably wrong, i expected there to be a clock.
> 
> The new semantics are:
> 
> We expect there to be a clock for sata_mv, and if there is no such
> clock, output a notice message, something is probably wrong, i
> expected there to be a clock.
> 
> We are going to see this notice message much more, when it is not
> expected.

So, the only problem is this message?
How do you suggest to tackle this now. Have #ifdef,#endif around this print?

-- 
viresh

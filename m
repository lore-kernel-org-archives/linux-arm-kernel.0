From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Feb 2014 20:10:09 +0100
Subject: [PATCH] net: phy: add suspend_halted module param
In-Reply-To: <CAGVrzcYUfq84ryVET9qNJvyFCnhFdU4c0fOHbNN4eE8_w6qsAQ@mail.gmail.com>
References: <1393174719-20806-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224191554.GC29288@lunn.ch> <530D1B7C.2090506@gmail.com>
 <20140226182117.GB14907@lunn.ch>
 <CAGVrzcYUfq84ryVET9qNJvyFCnhFdU4c0fOHbNN4eE8_w6qsAQ@mail.gmail.com>
Message-ID: <20140226191009.GC14907@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > As to the comment from davem about not using a kernel parameter. How
> > about turning it all around. Put a boolean parameter into DT PHY node
> > to indicate when it is safe to power down an idle phy?
> 
> Ah ah, nice try, but I do not think this belongs in DT, this is purely
> a software issue here, powering up/down the PHY itself works as
> expected.
> 
> How about we have this knob a sysfs parameter? This should be easy
> enough to tweak at runtime and debug in case thing go wrong.

With a kernel parameter i can place it into the bootargs of the chosen
node in DT. Solves the problem for everybody with a QNAP box. Same
goes for topkick and any other board which has a broken u-boot. A
sysfs parameter needs setting from user space, so it is not something
we can solve within the kernel.

   Andrew

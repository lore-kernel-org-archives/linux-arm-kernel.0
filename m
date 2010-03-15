From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 15 Mar 2010 07:55:38 -0500
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9DD46E.7060704@st.com>
References: <4B9DB823.1040809@st.com>		<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>		<4B9DC239.90407@st.com>	<1b68c6791003142241q274b573dl3e60bf25be462e68@mail.gmail.com>
	<4B9DD46E.7060704@st.com>
Message-ID: <4B9E2E4A.5070604@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR wrote:
> Actually, different peripherals share IO Pads (PL_GPIOs) and GPIO lines. Sending
> patch for drivers to support this doesn't look a great idea to me. Further this 
> may cause problems to users, for example: User have entered a inserted a module
> and by mistake or lack of knowledge, he disables already working IP. Now with 
> Kconfig concept this is taken care of at the beginning only. User can't select
> peripherals which can't be enabled simultaneously.
>   

Better to leave that knowledge out of the drivers and Kconfig, and just
let the system "blow up" at runtime if a bad combination is attempted. 
Making the system any smarter than that leads to drivers that are really
difficult to reuse elsewhere.

The "blow up" scenario isn't usually literal, of course, and the problem
is almost always spotted very early in the development effort.  So it
doesn't lead to problems.  The alternatives do.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com

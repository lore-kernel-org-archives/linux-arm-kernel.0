From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Nov 2015 21:09:01 +0100
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <HK2PR06MB0561D4F2B8C36A2A1427EE5A8A2B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <CAAEAJfD29_PSTw+srx7d2YrF+Akx-_94Wv9ifKzT+8HTfH5tGA@mail.gmail.com>
 <562FA053.6010208@st.com>
 <CALszF6C4B-S-o3E1OHK3+bKpDQ8a64Ly-ABNQwfSfj95y7qFyA@mail.gmail.com>
 <85aea33b93066d0959d98b56f8787ba3@agner.ch>
 <CALszF6Di3LWLu_W67Zdn2LyKKRF_5U241eKFKMmJ-0s+0boFag@mail.gmail.com>
 <CAAEAJfCL8veLOi9zi8kARL2kBcYQfxwKS13-mkGbQ_U6Ojg9LA@mail.gmail.com>
 <CALszF6Aodf0nXwsrE+Rtrg6UQw-1OMGY+BdadtK-dtHYv-Bqnw@mail.gmail.com>
 <CAAEAJfCfYo+J32PuW8k2p1S5eFxeCL6qTPeTLCGrNQrA0yC1kQ@mail.gmail.com>
 <20151028074304.GN4931@pengutronix.de>
 <HK2PR06MB0561D4F2B8C36A2A1427EE5A8A2B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20151103200901.GL4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, 

On Tue, Nov 03, 2015 at 05:52:53PM +0000, Chris Brandt wrote:
> > So the right fix is to move __v7m_setup_stack to .data I guess.
> 
> 
> Since my set of patches went nowhere, last week we had a look at doing just that (using a pre-allocated stack in .data instead of hard coding to the top of PLAT_PHYS_OFFSET).
> 
> Here's the code we came up with. Seems to work on XIP and non-XIP builds as well as SMP and non-SMP.
> 
> 
> Maybe you can try this technique to allocate the temporary stack in the data section.
I think for v7-M it's easier. Just move the stack to .data and use it
from there where the linker put it to.

> arch/arm/mm/proc-v7.S |   25 +++++++++++++++++++++++--
I would have expected a patch to v7m in this thread.

You seem to fix a different problem so I suggest you start a new thread
with a subject that gets the attention from people that know about the
v7-[AR] details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

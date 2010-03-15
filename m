From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 15 Mar 2010 06:22:22 +0000
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
References: <4B9DB99A.5040104@st.com>
	<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
Message-ID: <20100315062221.GE31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 02:18:45PM +0900, jassi brar wrote:
> On Mon, Mar 15, 2010 at 1:37 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> > In our SOC (SPEArxxx), we have few peripherals which share common interrupt
> > line.
> how about set_irq_chained_handler ?

How about making drivers deal with shared irqs properly... most will, with
a small amount of TLC support the usage of one interrupt line shared
between more than one peripheral. PCs often share interrupts if the IRQ
controller hasn't been put into an extended mode.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

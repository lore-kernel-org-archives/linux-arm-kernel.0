From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Feb 2012 10:55:06 +0000
Subject: [PATCH] ARM/sp810: introduce API to change system mode
In-Reply-To: <CACRpkdaG2e12fdCFDUoQ_n71VcqU3ZpkH0raHW+EAZg==JOxrg@mail.gmail.com>
References: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
 <CACRpkdaG2e12fdCFDUoQ_n71VcqU3ZpkH0raHW+EAZg==JOxrg@mail.gmail.com>
Message-ID: <20120227105506.GS22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 11:38:14AM +0100, Linus Walleij wrote:
> Maybe I'm delusional but I think this could help centralizing the use
> of the SP* cells, since they're obviously used in both SPEAr and
> versatile express.

They can be used in any PrimeXsys based system, and I don't see that
there's anything which guarantees having both a SP810 and SP804
together.

There are platforms which have SP804 without SP810 - Integrator CP
and bcmring seem to fall into that category.

But... the register concerned does a whole load of other things, and
I'm not sure we want to have accesses to it de-centralized.

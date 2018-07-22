From: akpm@linux-foundation.org (Andrew Morton)
Date: Sat, 21 Jul 2018 22:41:18 -0700
Subject: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
In-Reply-To: <20180721162610.GA15622@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
 <20180721162610.GA15622@sophia>
Message-ID: <20180721224118.ff26734be0f5db552afcbe7c@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 21 Jul 2018 12:26:10 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> >Also, many many drivers deal with signals-as-an-electrical-thing - is
> >it appropriate for this particular driver to take that namespace?
> 
> In the context of the Generic Counter paradigm, a "Signal" is an
> abstraction for the stream of data that is fed to the counter device for
> evaluation (triggering updates for the readable "Count"). In many cases
> a "Signal" correlates with a physical electrical line (for example the A
> and B electrical lines for a quadrature encoder), but this isn't a hard
> requirement as the paradigm permits more abstract data streams.
> 
> I decided on "Signal" to match the naming convention that appears in the
> datasheets of many counter devices, but "Line" may be a decent
> alternative name we could use to indicate a counter device input data
> stream.
> 
> I'd like to get some other opinions as well before I make a naming
> change to "Signal" -- whether to stay with "Signal," switch to "Line," or
> rename to something else. For what it's worth, I think it's unlikely for
> a counter device driver author to confuse a Counter Signal with the
> Linux OS signal within the context of the Generic Counter paradigm and
> their respective counter device datasheet.

gc_signal_* would be better.  That retains "signal", but makes
it clear that the symbols belong to generic counter.

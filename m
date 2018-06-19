From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 Jun 2018 10:24:22 -0700
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
In-Reply-To: <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
Message-ID: <20180619172422.GB16846@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 03:35:07PM +0200, Ard Biesheuvel wrote:
> >>
> >> +       /* this needs to be a separate macro or \@ does not work correctly
> >> */
> >> +       .macro  __badr, c, rd, sym
> >> +       .eqv    .Lsym\@, \sym
> >> +       adr\c   \rd, .Lsym\@ + 1
> >
> >
> > Wild shot, but the following works for me.
> >
> >         .eqv    .Lsym\@, \sym + 1
> >         adr\c   \rd, .Lsym\@
> >
> > Does it make sense ?
> >
> 
> Interesting. Do you mean this works with your 2.30 binutils that
> triggers the original issue?
> 

Yes, it does. It is also the solution used for some graphics libraries,
though of course now I don't find the link anymore.

Guess this is going nowhere given Russell's response, so I'll just
live with it, like obviously everyone else does already. I built
a toolchain using gcc 7.3.0 and binutils 2.28.1 which "solves"
the problem for me.

Guenter

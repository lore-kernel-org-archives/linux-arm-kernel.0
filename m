From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 19 Jun 2017 15:42:09 -0300
Subject: [PATCH] [perf/core branch] perf coresight: Fix ARM builds caused
 by misplaced __printf
In-Reply-To: <CANLsYkyG3E9xiOyJz_5EA0B0oQGsSCy2oW7i1iY5YUxU1imKng@mail.gmail.com>
References: <20170616145907.baba73eda242efe194e072d0@arm.com>
 <CANLsYkyG3E9xiOyJz_5EA0B0oQGsSCy2oW7i1iY5YUxU1imKng@mail.gmail.com>
Message-ID: <20170619184209.GB13640@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Jun 19, 2017 at 11:51:20AM -0600, Mathieu Poirier escreveu:
> On 16 June 2017 at 13:59, Kim Phillips <kim.phillips@arm.com> wrote:
> > -static int cs_device__print_file(const char *name, const char *fmt, ...) __printf(2, 3)
> > +static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
> >  {
> >         va_list args;
> >         FILE *file;
> 
> I just tested Kim's solution on my side.
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks for checking, since I haven't pushed this to Ingo I just squashed
Kim's fix into the buggy cset.

Now I'm trying to build it with lots of cross build containers to see if
there are any other problems before push this up to Ingo.

- Arnaldo

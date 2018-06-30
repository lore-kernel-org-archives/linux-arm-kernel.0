From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 29 Jun 2018 19:41:17 -0700
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
 <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
 <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com>
Message-ID: <20180629194117.01b2d31e805808eee5c97b4d@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018 14:45:08 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:

> >> What kind of memory consumption testing would you like to see?
> >
> > Well, 100kb or so is a teeny amount on virtually any machine.  I'm
> > assuming the savings are (much) more significant once the machine gets
> > loaded up and doing work?
> 
> So with clean kernel after boot we get 40 kb memory usage. With KASAN
> it is ~120 kb, which is 200% overhead. With KHWASAN it's 50 kb, which
> is 25% overhead. This should approximately scale to any amounts of
> used slab memory. For example with 100 mb memory usage we would get
> +200 mb for KASAN and +25 mb with KHWASAN. (And KASAN also requires
> quarantine for better use-after-free detection). I can explicitly
> mention the overhead in %s in the changelog.
> 
> If you think it makes sense, I can also make separate measurements
> with some workload. What kind of workload should I use?

Whatever workload people were running when they encountered problems
with KASAN memory consumption ;)

I dunno, something simple.  `find / > /dev/null'?

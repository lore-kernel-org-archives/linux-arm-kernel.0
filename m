From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 28 Jun 2018 12:40:39 -0700
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
Message-ID: <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jun 2018 20:29:07 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:

> >> Slab memory usage after boot [2]:
> >> * ~40 kb for clean kernel
> >> * ~105 kb + 1/8th shadow ~= 118 kb for KASAN
> >> * ~47 kb + 1/16th shadow ~= 50 kb for KHWASAN
> >>
> >> Network performance [3]:
> >> * 8.33 Gbits/sec for clean kernel
> >> * 3.17 Gbits/sec for KASAN
> >> * 2.85 Gbits/sec for KHWASAN
> >>
> >> Note, that KHWASAN (compared to KASAN) doesn't require quarantine.
> >>
> >> [1] Time before the ext4 driver is initialized.
> >> [2] Measured as `cat /proc/meminfo | grep Slab`.
> >> [3] Measured as `iperf -s & iperf -c 127.0.0.1 -t 30`.
> >
> > The above doesn't actually demonstrate the whole point of the
> > patchset: to reduce KASAN's very high memory consumption?
> 
> You mean that memory usage numbers collected after boot don't give a
> representative picture of actual memory consumption on real workloads?
> 
> What kind of memory consumption testing would you like to see?

Well, 100kb or so is a teeny amount on virtually any machine.  I'm
assuming the savings are (much) more significant once the machine gets
loaded up and doing work?

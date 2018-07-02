From: willy@infradead.org (Matthew Wilcox)
Date: Mon, 2 Jul 2018 13:33:21 -0700
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
Message-ID: <20180702203321.GA8371@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 05:04:28PM -0700, Kostya Serebryany wrote:
> The problem is more significant on mobile devices than on desktop/server.
> I'd love to have [K]HWASAN on x86_64 as well, but it's less trivial since x86_64
> doesn't have an analog of aarch64's top-byte-ignore hardware feature.

Well, can we emulate it in software?

We've got 48 bits of virtual address space on x86.  If we need all 8
bits, then that takes us down to 40 bits (39 bits for user and 39 bits
for kernel).  My laptop only has 34 bits of physical memory, so could
we come up with a memory layout which works for me?

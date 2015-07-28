From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 28 Jul 2015 14:45:37 -0700
Subject: [PATCH] lib: Make _find_next_bit helper function inline
In-Reply-To: <55B7F2C6.9010000@gmail.com>
References: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
 <55B7F2C6.9010000@gmail.com>
Message-ID: <20150728144537.67d46b5714c99d25f0bb33fb@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jul 2015 00:23:18 +0300 Yury <yury.norov@gmail.com> wrote:

> But I think, before/after for x86 is needed as well.

That would be nice.

> And why don't you consider '__always_inline__'? Simple inline is only a 
> hint and
> guarantees nothing.

Yup.  My x86_64 compiler just ignores the "inline".  When I use
__always_inline, find_bit.o's text goes from 776 bytes to 863. 
Hopefully we get something in return for that bloat!


Also, if _find_next_bit() benefits from this then _find_next_bit_le()
will presumably also benefit.

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 11:13:27 +0100
Subject: [PATCH 18/19] pinctrl: sirf: atlas7: make use of raw_spinlock
 variants
In-Reply-To: <c68b030b8903bb1ca2f501b2e5c651d9206b1133.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
 <c68b030b8903bb1ca2f501b2e5c651d9206b1133.1489015238.git.julia@ni.com>
Message-ID: <CACRpkdaVqsZ0dogiC7KX4Vyax7KugJoaLNAXdXowt=w9y=MfdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 9, 2017 at 5:22 PM, Julia Cartwright <julia@ni.com> wrote:

> The sirf atlas7 pinctrl drivers currently implement an irq_chip for
> handling interrupts; due to how irq_chip handling is done, it's
> necessary for the irq_chip methods to be invoked from hardirq context,
> even on a a real-time kernel.  Because the spinlock_t type becomes a
> "sleeping" spinlock w/ RT kernels, it is not suitable to be used with
> irq_chips.
>
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw spinlock.
>
> Signed-off-by: Julia Cartwright <julia@ni.com>

Patch applied.

Yours,
Linus Walleij

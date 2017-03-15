From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 11:14:13 +0100
Subject: [PATCH 19/19] pinctrl: sunxi: make use of raw_spinlock variants
In-Reply-To: <6b509f22ec93562892e787507e62137cee7c9114.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
 <6b509f22ec93562892e787507e62137cee7c9114.1489015238.git.julia@ni.com>
Message-ID: <CACRpkdb=mpYxABtkjD4s1+jAPCsLvMNrJpbCOQ6On7sFUkvtww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 9, 2017 at 5:22 PM, Julia Cartwright <julia@ni.com> wrote:

> The sunxi pinctrl driver currently implement an irq_chip for handling
> interrupts; due to how irq_chip handling is done, it's necessary for the
> irq_chip methods to be invoked from hardirq context, even on a a
> real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
>
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw spinlock.
>
> Signed-off-by: Julia Cartwright <julia@ni.com>

Patch applied.

Yours,
Linus Walleij

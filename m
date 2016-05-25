From: davem@davemloft.net (David Miller)
Date: Wed, 25 May 2016 12:30:17 -0700 (PDT)
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160525.123017.1597296248000772613.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yury Norov <ynorov@caviumnetworks.com>
Date: Tue, 24 May 2016 03:04:30 +0300

> +To clear that top halves, automatic wrappers are introduced. They clear all
> +required registers before passing control to regular syscall handler.

Why have one of these for every single compat system call, rather than
simply clearing the top half of all of these registers unconditionally
in the 32-bit system call trap before the system call is invoked?

That's what we do on sparc64.

And with that, you only need wrappers for the case where there needs
to be proper sign extention of a 32-bit signed argument.

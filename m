From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 May 2013 15:31:58 +0200 (CEST)
Subject: [RFC patch 7/8] fixup 2/2: genirq: generic chip: Add linear irq
 domain support
In-Reply-To: <1367843533-7117-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130503214629.810207749@linutronix.de>
 <1367843533-7117-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367843533-7117-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <alpine.LFD.2.02.1305061525420.3095@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 May 2013, Sebastian Hesselbarth wrote:

> mask_cache pointer also needs to be initialized for domain generic
> chips.

It's not only the mask cache pointer. We also need to initialize the
mask cache itself. I solved it by spitting out that code from
irq_setup_generic_chip().

Thanks,

	tglx

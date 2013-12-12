From: m.mann@arkona-technologies.de (Matthias Mann)
Date: Thu, 12 Dec 2013 20:29:54 +0100
Subject: [PATCH] pci: designware: fix missing msi irqs
In-Reply-To: <20131212182903.409515738@gmail.com>
References: <20131212182903.409515738@gmail.com>
Message-ID: <52AA0EB2.2070701@arkona-technologies.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.12.2013 19:29, schrieb Harro Haan:
> The interrupts were cleared after the irq handler was called.
> This means that new interrupts that occur after the handler handled
> the previous irq but before the interrupt is cleared will be missed.

I discovered the same issue today. I'll test that patch tomorrow.

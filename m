From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 2 Mar 2010 13:34:34 -0800
Subject: [PATCH 4/7] mmc: at91_mci: use DMA buffer for read
In-Reply-To: <0374bbdf963e39fc012ad7885f9036c00dbb4079.1267209149.git.nicolas.ferre@atmel.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<0374bbdf963e39fc012ad7885f9036c00dbb4079.1267209149.git.nicolas.ferre@atmel.com>
Message-ID: <20100302133434.761df661.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Feb 2010 19:39:32 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);

It's a feature of kunmap_atomic() that it will accept a pointer to any
location in the page.  So the subtraction isn't strictly needed.

And if the subtraction is removed, the (void*) cast can also be removed.

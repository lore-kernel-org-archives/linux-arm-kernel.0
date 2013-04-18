From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 18 Apr 2013 16:21:47 +0930
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <87wqs02uws.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PranavkumarSawargaonkar <pranavkumar@linaro.org> writes:
> From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>
> This patch implements early printk support for virtio-mmio console devices without using any hypercalls.

This makes some sense, though not sure that early console *read* makes
much sense.  I can see the PCI version of this being useful as well.

The spec definition for this will be interesting, because it can be used
before the device is initialized (something which is generally
verboten).

Cheers,
Rusty.

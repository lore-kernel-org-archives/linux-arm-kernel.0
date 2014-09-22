From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Sep 2014 14:03:51 +0100
Subject: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <20140922095939.GB1406@katana>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
 <CAE0=X_0VQ8rWrUgbsgKm1MwCP8bwWm3UJPq9p=xNDfjP4CC7Bg@mail.gmail.com>
 <20140922095939.GB1406@katana>
Message-ID: <20140922130351.GL5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 11:59:39AM +0200, Wolfram Sang wrote:
> IRQ_NONE is "this interrupt wasn't by me" so for shared IRQs, the next
> handler can check.

Err, no it isn't.  IRQ_NONE has no such effect.  All handlers on a
shared interrupt are always run irrespective of the return value from
any particular interrupt handler.  See kernel/irq/handle.c.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 27 May 2011 13:07:26 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
Message-ID: <20110527120725.GV969@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> With all of them, even writel(), you don't know when the actual
> hardware write happens. You can issue a DSB after to ensure write
> completion (I think defined as the device begins to change its state
> as a result of the write) but you can't tell whether the device
> finished changing its state. For that you would need other means like
> reading back from the device.

With PCI on x86, writel() may not reach the hardware immediately (PCI
queues the writes), so I believe you need readl() to some register on
the same device to ensure the write has been acknowledged by the
device.

Does DSB on ARM replace the need for that readl()?

-- Jamie

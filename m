From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 12 Feb 2017 02:17:44 +0100
Subject: [PATCH] ARM: dts: armada-385-synology-ds116: add support for
 Synology DS116 NAS
In-Reply-To: <20170212005350.GA18612@1wt.eu>
References: <1486805073-15534-1-git-send-email-w@1wt.eu>
 <20170212004031.GA7328@lunn.ch> <20170212005350.GA18612@1wt.eu>
Message-ID: <20170212011744.GB7328@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But won't that squat the I/O address and prevent me from using all the
> other codes via the regular serial port ?

Nope. That driver hijacks the serial port during shutdown to actually
turn the power off. The rest of the time, it does not touch the serial
port. Userspace, or the rest of the kernel is free to use it.

	Andrew

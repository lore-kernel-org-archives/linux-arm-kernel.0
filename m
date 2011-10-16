From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Oct 2011 22:34:07 +0200
Subject: [PATCH] mmc: mmci: Do not release spinlock in request_end
In-Reply-To: <4E97F131.6090406@stericsson.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
	<20111013142914.GZ21648@n2100.arm.linux.org.uk>
	<1318521592.2090.16.camel@linaro1>
	<4E97E6CF.1000601@stericsson.com>
	<20111014074224.GQ21648@n2100.arm.linux.org.uk>
	<4E97EA10.6040800@stericsson.com>
	<20111014080318.GR21648@n2100.arm.linux.org.uk>
	<4E97F131.6090406@stericsson.com>
Message-ID: <CAKnu2MrohC0=1kC2Qo=BrcPxgEQ16B4EczehUbz1JtNRx2Cb4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/14 Ulf Hansson <ulf.hansson@stericsson.com>:

> So how can we handle to merge it via mmc tree instead? Will you be able to
> "Ack" patches for mmci so Chris Ball can merge them for the mmc tree
> instead?

If you get Russell's ACK on it (provided it is merged on top of
Adrians patch) Chris can surely merge it into his tree.
He's already merging subsystem-wide patches (like Adrians)
to his tree, often touching several drivers in the process, as is
custom.

Have we checked if there are more spin_lock():s in the
other MMC host drivers that also should be removed as a
result of this or is MMCI the sole sinner?

Cross-tree dependencies is a mess, sadly we have no way
of solving that which is perfect. (Yet.)

Yours,
Linus Walleij

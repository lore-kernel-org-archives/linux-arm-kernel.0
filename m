From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 18:09:40 +0000
Subject: [PATCH 0/3] serial: amba-pl011: fix race conditions during
 initialisation
In-Reply-To: <1386670740-16914-1-git-send-email-tixy@linaro.org>
References: <1386670740-16914-1-git-send-email-tixy@linaro.org>
Message-ID: <20131210180940.GA19513@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 10:18:57AM +0000, Jon Medhurst wrote:

> When a UART that is being used for a kernel console is also opened
> by user-side, e.g. for use as a terminal, then there are race conditions
> which can lead to terminal input being disabled and console output being
> corrupted. This small patch series fixes these.
> 
> Jon Medhurst (3):
>       serial: amba-pl011: use port lock to guard control register access
>       serial: amba-pl011: factor out code for writing LCR_H register
>       serial: amba-pl011: preseserve hardware settings during initialisation

Given that this seems relatively easy to trigger when you know how and
renders the device non-functional perhaps this should be considered for
stable too?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/60ba34f5/attachment.sig>

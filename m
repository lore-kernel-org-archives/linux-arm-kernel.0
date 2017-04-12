From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 12 Apr 2017 22:20:26 +0200
Subject: [PATCH v2 3/4] bluetooth: hci_uart: add LL protocol serdev driver
 support
In-Reply-To: <20170407143516.9945-1-robh@kernel.org>
References: <20170407143516.9945-1-robh@kernel.org>
Message-ID: <1EF987AA-8426-43BF-B92B-62AFF554FAA1@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> Turns out that the LL protocol and the TI-ST are the same thing AFAICT.
> The TI-ST adds firmware loading, GPIO control, and shared access for
> NFC, FM radio, etc. For now, we're only implementing what is needed for
> BT. This mirrors other drivers like BCM and Intel, but uses the new
> serdev bus.
> 
> The firmware loading is greatly simplified by using existing
> infrastructure to send commands. It may be a bit slower than the
> original code using synchronous functions, but the real bottleneck is
> likely doing firmware load at 115.2kbps.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth at vger.kernel.org
> ---
> v2:
> - Use IS_ENABLED() to fix module build
> 
> drivers/bluetooth/hci_ll.c | 261 ++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 260 insertions(+), 1 deletion(-)

can you re-send any missing patch on top of today's bluetooth-next tree.

Regards

Marcel

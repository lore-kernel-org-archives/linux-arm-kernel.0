From: davem@davemloft.net (David Miller)
Date: Wed, 06 Apr 2016 23:57:31 -0400 (EDT)
Subject: [PATCH net-next V3 05/16] net: fec: reduce interrupts
In-Reply-To: <5705AD07.10009@boundarydevices.com>
References: <1459909562-22865-6-git-send-email-troy.kisky@boundarydevices.com>
 <20160406.172008.266926707628676037.davem@davemloft.net>
 <5705AD07.10009@boundarydevices.com>
Message-ID: <20160406.235731.57253886354009409.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com>
Date: Wed, 6 Apr 2016 17:42:47 -0700

> Sure, that's an easy change. But if a TX int is what caused the
> interrupt and masks them, and then a RX packet happens before napi
> runs, do you want the TX serviced 1st, or RX ?

If you properly split your driver up into seperate interrupt/poll
instances, one for TX one for RX, you wouldn't need to ask me
that question now would you?

:-)

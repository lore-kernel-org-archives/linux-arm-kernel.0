From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 6 Nov 2015 20:37:38 +0100
Subject: [RFC PATCH 0/2] net: mvneta: Introduce RSS support
In-Reply-To: <1446834911-29910-1-git-send-email-gregory.clement@free-electrons.com>
References: <1446834911-29910-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKcOLsjGj1iyEiPdPkdkNS2O1-RytNMZUCgUCv9QUdY6FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,


> I also choose to associate all the TX queues on the same CPU that the
> one associated to the RX queue. It allows to contain all the
> interrupts on the same CPU. I think that an improvement on this side
> would be the support of the XPS.
>

Did you make some tries? E.g. after mapping certain txqs to CPU1, when
using them was mvneta_tx() executing only on this CPU? Or it rather
means that the irq will hit according to the mapping? As far as I know
the HW, the latter should be true, which would mean the real XPS with
this controller is impossible and the maximum we can control is the
irq.

I think it may be worth to unmask TX irqs on all cpus, so all percpu
napi's would be able to read tx_cause and process sent packets. I'm
looking forward to your opinion.

Best regards,
Marcin

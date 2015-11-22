From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 22 Nov 2015 22:37:56 +0100
Subject: [PATCH 00/13] mvneta Buffer Management and enhancements
In-Reply-To: <12984648.7CKVgBs7pu@wuerfel>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <12984648.7CKVgBs7pu@wuerfel>
Message-ID: <CAPv3WKfqpBgjERwU3VTPeM7NRkSzz=Ny13WhLvbT_yHfaG1nWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

2015-11-22 21:06 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 22 November 2015 08:53:46 Marcin Wojtas wrote:
>>
>> 3. Optimisations - concatenating TX descriptors' flush, basing on
>> xmit_more support and combined approach for finalizing egress processing.
>> Thanks to HR timer buffers can be released with small latency, which is
>> good for low transfer and small queues. Along with the timer, coalescing
>> irqs are used, whose threshold could be increased back to 15.
>>
>>
>
> If you are already reworking the TX path, it probably makes sense to
> support BQL as well, see the Marvell skge and sky2 drivers for examples
> using netdev_{tx_,}{sent,completed}_queue.
>

Good idea, I'll take a look.

Best regards,
Marcin

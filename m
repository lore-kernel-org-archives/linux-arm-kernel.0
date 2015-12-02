From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Wed, 2 Dec 2015 18:27:14 +0530
Subject: [PATCH 3/6] net: thunderx: Increase transmit queue length
In-Reply-To: <013301d12cfd$0c958a90$25c09fb0$@samsung.com>
References: <y@samsung.com>
 <1448961223-41888-4-git-send-email-sunil.kovvuri@gmail.com>
 <01d101d12c46$2de43b40$89acb1c0$@samsung.com>
 <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
 <CA+sq2Ce9oH-kCDO8hK_wX+ZZdXyyBuT4V2bt5Ab+2=pEX+BO+w@mail.gmail.com>
 <00cb01d12ce0$9f090540$dd1b0fc0$@samsung.com>
 <00eb01d12cec$a32aa500$e97fef00$@samsung.com>
 <013301d12cfd$0c958a90$25c09fb0$@samsung.com>
Message-ID: <CA+sq2CfSNBQaQnw32tu4ZcZYLd6ybVZ3Ka5Oz=s1YUNegZpd-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>After getting it working in guest i tried to apply it to host. With total of 128 virtual functions (= 128 interfaces) it does not work at all.
> Even after bumping cma region size to insane value of 2GB more than half of interfaces still failed to allocate queues.
> And after setting cma=3G i could not mount my rootfs.

Here what you are saying is half of the interfaces were initialized
succesfully and rest didn't.
So this issue is not something which is introduced by this patch.

> Can we use some other method for allocating queues, which would not require such a huge coherent pool?
There are so many drivers which use dma_alloc_coherent() directly or
via pci_alloc_consistent() to
allocate memory. How many drivers should we modify.

From: davem@davemloft.net (David Miller)
Date: Tue, 01 Dec 2015 15:21:27 -0500 (EST)
Subject: [PATCH] drivers: net: xgene: fix Tx flow control
In-Reply-To: <1448680951-4730-1-git-send-email-isubramanian@apm.com>
References: <1448680951-4730-1-git-send-email-isubramanian@apm.com>
Message-ID: <20151201.152127.1326770277234261993.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Fri, 27 Nov 2015 19:22:31 -0800

> Currently the Tx flow control is based on reading the hardware state,
> which is not accurate since it may not reflect the descriptors that
> are not yet reached the memory.
> 
> To accurately control the Tx flow, changing it to be software based.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Tested-by: Khuong Dinh <kdinh@apm.com>

Having a new atomic operation for every completion descriptor
operation is very excessive.

Especially when there is probably some other lock being held in all
of these paths upon which you can use for synchornization.

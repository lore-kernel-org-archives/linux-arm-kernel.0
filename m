From: davem@davemloft.net (David Miller)
Date: Thu, 17 Dec 2015 15:46:05 -0500 (EST)
Subject: [PATCH v2] drivers: net: xgene: fix Tx flow control
In-Reply-To: <1450333565-23670-1-git-send-email-isubramanian@apm.com>
References: <1450333565-23670-1-git-send-email-isubramanian@apm.com>
Message-ID: <20151217.154605.1269611462220525072.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Wed, 16 Dec 2015 22:26:05 -0800

> Currently the Tx flow control is based on reading the hardware state,
> which is not accurate since it may not reflect the descriptors that
> are not yet reached the memory.
> 
> To accurately control the Tx flow, changing it to be software based.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> ---
> 
> v2: Address v1 review comments
> 	- Removed use of atomic_t
> 	- Added tx_level and txc_level counters to pdata
> 
> v1: Initial version

Applied, thanks.

From: davem@davemloft.net (David Miller)
Date: Fri, 28 Jul 2017 11:42:34 -0700 (PDT)
Subject: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
In-Reply-To: <20170728125416.j7gcgvnxgv2gq73u@tardis>
References: <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
Message-ID: <20170728.114234.665847938315546094.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boqun Feng <boqun.feng@gmail.com>
Date: Fri, 28 Jul 2017 20:54:16 +0800

> Hi Jonathan,
> 
> FWIW, there is wakeup-missing issue in swake_up() and swake_up_all():
> 
> 	https://marc.info/?l=linux-kernel&m=149750022019663
> 
> and RCU begins to use swait/wake last year, so I thought this could be
> relevant.
> 
> Could you try the following patch and see if it works? Thanks.

Just FYI I'm testing this patch now on sparc64...

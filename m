From: davem@davemloft.net (David Miller)
Date: Wed, 02 Jun 2010 06:13:44 -0700 (PDT)
Subject: [PATCH v2] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <1275163490-13027-1-git-send-email-eric@eukrea.com>
References: <20100529.001534.57459102.davem@davemloft.net>
	<1275163490-13027-1-git-send-email-eric@eukrea.com>
Message-ID: <20100602.061344.129778393.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>
Date: Sat, 29 May 2010 22:04:50 +0200

> * in the actual driver, calling fec_stop and fec_enet_init doesn't
> allow to have a working network interface at resume (where a
> ifconfig down and up is required to recover the interface)
> * by using fec_enet_close and fec_enet_open, this patch solves this
> problem and handle the case where the link changed between suspend
> and resume
> * this patch also disable clock at suspend and reenable it at resume
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

Applied, thanks.

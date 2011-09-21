From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Sep 2011 13:52:24 +0800
Subject: [PATCH] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
References: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110921055223.GA28907@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Tue, Sep 20, 2011 at 06:57:45PM -0700, Barry Song wrote:
> we save the l2x0 registers at the first initialization, and restore
> them after resuming every time.
> 
I'm unsure that it will work for cases like imx6q, where L2 cache is
retained and the controller needs to be restored at the very beginning
of the resume entry (running on physical space).

Regards,
Shawn

> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/include/asm/outercache.h |    7 +++
>  arch/arm/mm/cache-l2x0.c          |   81 ++++++++++++++++++++++++++++++++----
>  2 files changed, 79 insertions(+), 9 deletions(-)

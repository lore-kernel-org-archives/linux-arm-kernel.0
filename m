From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 22:20:59 +0900
Subject: [PATCH 2/3] ARM: shmobile: Force ARM mode to compile reset
 vector for secondary CPUs
In-Reply-To: <1373421397-1786-3-git-send-email-koba@kmckk.co.jp>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
 <1373421397-1786-3-git-send-email-koba@kmckk.co.jp>
Message-ID: <20130710132059.GC13716@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 10:56:36AM +0900, Tetsuyuki Kobayashi wrote:
> Instructions start from boot vector must be ARM mode.
> This patch specify ARM mode explicitly and use 'bx' instruction to be
> able to change to Thumb mode.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
>  arch/arm/mach-shmobile/headsmp.S |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks, I have queued this up with Magnus's ack in the thumb-fixes
branch of my renesas tree on kernel.org. It should be
included in the renesas-next-20130710v2 tag.

From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Wed, 11 Nov 2015 14:17:42 +0100
Subject: [PATCH] netfilter: nfnetlink_log: work around uninitialized
 variable warning
In-Reply-To: <17817903.Md6b3ydRpX@wuerfel>
References: <17817903.Md6b3ydRpX@wuerfel>
Message-ID: <20151111131742.GA6079@salvia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 01:08:15PM +0100, Arnd Bergmann wrote:
> After a recent (correct) change, gcc started warning about the use
> of the 'flags' variable in nfulnl_recv_config()
> 
> net/netfilter/nfnetlink_log.c: In function 'nfulnl_recv_config':
> net/netfilter/nfnetlink_log.c:320:14: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/netfilter/nfnetlink_log.c:828:6: note: 'flags' was declared here
> 
> The warning first shows up in ARM s3c2410_defconfig with gcc-4.3 or
> higher (including 5.2.1, which is the latest version I checked) I
> tried working around it by rearranging the code but had no success
> with that.
> 
> As a last resort, this initializes the variable to zero, which shuts
> up the warning, but means that we don't get a warning if the code
> is ever changed in a way that actually causes the variable to be
> used without first being written.

Applied, thanks!

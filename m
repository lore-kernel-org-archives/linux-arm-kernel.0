From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 09:59:16 -0400
Subject: [PATCH for v3.16] ARM: mvebu: Fix coherency bus notifiers by
 using separate notifiers
In-Reply-To: <1404826657-6977-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1404826657-6977-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140708135916.GB13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 10:37:37AM -0300, Ezequiel Garcia wrote:
> Currently, the coherency fabric support registers two bus notifiers;
> one for platform, one for pci bus types, with the same notifier block.
> However, this is illegal and can cause serious issues: the notifier
> block is also a link in the notifier list and cannot be inserted twice.
> 
> This commit fixes this by using different notifier blocks (with the same
> notifier callback) to set the platform and pci bus types notifiers.
> 
> Fixes: b0063aad5dd8 ("ARM: mvebu: use hardware I/O coherency also for PCI devices")
> Reported-by: Paolo Pisati <p.pisati@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.

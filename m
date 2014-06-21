From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 20:55:14 -0400
Subject: [PATCHv5 2/3] ARM: mvebu: move Armada 375 external abort logic
 as a quirk
In-Reply-To: <1402585772-10405-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1402585772-10405-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140621005514.GX21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 05:09:31PM +0200, Thomas Petazzoni wrote:
> In preparation to a small re-organization of the initialization
> sequence in board-v7.c, this commit moves the registration of the
> custom external abort handler on Armada 375 later in the boot
> sequence, and makes it more similar to the other quirks that we
> already have. There is indeed no need to register this abort handler
> particularly early, it simply needs to be registered before switching
> to userspace.
> 
> In addition to this, this commit makes the registration of the custom
> abort handler conditional on Armada 375 Z1, because Armada 375 A0 and
> later iterations are not affected by the issue.
> 
> This commit was tested on both Armada 375 Z1 and Armada 375 A0
> platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Patches 2 and 3 applied to mvebu/soc

thx,

Jason.

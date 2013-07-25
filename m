From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 11:25:38 -0400
Subject: [PATCH] ARM: dove: fix missing __init section of
 dove_mpp_gpio_mode
In-Reply-To: <1372690572-2184-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372690572-2184-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130725152538.GG23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 04:56:12PM +0200, Sebastian Hesselbarth wrote:
> Legacy dove_mpp_gpio_mode calls orion_gpio_set_valid which is in
> __init section. Offending function is not, so this causes a section
> mismatch. To fix the mismatch, also move dove_mpp_gpio_mode to
> __init section.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-dove/mpp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to mvebu/fixes-non-critical

thx,

Jason.

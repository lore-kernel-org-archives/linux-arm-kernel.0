From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 08 Feb 2013 17:51:42 +1300
Subject: [PATCH 0/4] Improve CLKSRC_OF matching
In-Reply-To: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
Message-ID: <1360299102.31290.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-07 at 13:09 -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In the recently added support for OF based clocksource init, a device node
> will be matched twice. We can fix this by passing the device node to the
> init functions and removing the match functions within the init functions.
> 
> This is based on arm-soc for-next branch and commit "of: fix incorrect
> return value of of_find_matching_node_and_match()" in my DT for-next
> branch.
> 
> Rob
> 
> Rob Herring (4):
>   clocksource: pass DT node pointer to init functions
>   clocksource: bcm2835: use the device_node pointer passed to init
>   clocksource: vt8500: use the device_node pointer passed to init
>   clocksource: tegra20: use the device_node pointer passed to init
> 
>  drivers/clocksource/bcm2835_timer.c |   12 +-----
>  drivers/clocksource/clksrc-of.c     |    4 +-
>  drivers/clocksource/tegra20_timer.c |   70 ++++++++++++++---------------------
>  drivers/clocksource/vt8500_timer.c  |   14 +------
>  4 files changed, 31 insertions(+), 69 deletions(-)
> 

Looks fine, although I didn't get a CC for the vt8500 patch so I had to
go hunting for it :)

For patches 1 & 3:
Acked-by: Tony Prisk <linux@prisktech.co.nz>

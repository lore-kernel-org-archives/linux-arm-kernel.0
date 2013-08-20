From: rob.herring@calxeda.com (Rob Herring)
Date: Tue, 20 Aug 2013 14:12:17 -0500
Subject: [RFC 05/17] ARM: highbank: remove custom .init_time hook
In-Reply-To: <1376964271-22715-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5213BF91.3030300@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 09:04 PM, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks. Highbank clock provider need a reference
> to system registers, as a workaround current clk driver maps those
> independent of arch code now.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Notes:
> - I suggest to consolidate the four single clock providers into a single
>   provider with one node if possible.

And how do you suggest doing that while maintaining the DT ABI?

> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-highbank/highbank.c |   23 +++++++----------------
>  drivers/clk/clk-highbank.c        |   10 +++++++---
>  2 files changed, 14 insertions(+), 19 deletions(-)

Acked-by: Rob Herring <rob.herring@calxeda.com>

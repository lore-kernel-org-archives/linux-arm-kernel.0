From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 17:45:32 +0100
Subject: [PATCH] ARM: socfpga: hide unused functions
In-Reply-To: <56CC7947.6000909@opensource.altera.com>
References: <1456236527-189885-1-git-send-email-arnd@arndb.de>
 <56CC7947.6000909@opensource.altera.com>
Message-ID: <4863197.tpCxBrE0HK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 February 2016 09:22:47 Dinh Nguyen wrote:
> 
> On 02/23/2016 08:08 AM, Arnd Bergmann wrote:
> > The cpu_die and cpu_kill callbacks are only used when CONFIG_HOTPLUG_CPU
> > is enabled, otherwise we get a warning about them:
> > 
> > arch/arm/mach-socfpga/platsmp.c:102:13: error: 'socfpga_cpu_die' defined but not used [-Werror=unused-function]
> > arch/arm/mach-socfpga/platsmp.c:115:12: error: 'socfpga_cpu_kill' defined but not used [-Werror=unused-function]
> > 
> > This adds the appropriate #ifdef.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Applied to next/fixes-non-critical, thanks!

	Arnd

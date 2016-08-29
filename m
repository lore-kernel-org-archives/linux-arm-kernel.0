From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 14:27:20 +0800
Subject: [PATCH] ARM: imx6: add opp table when cpufreq is enabled
In-Reply-To: <20160829061910.GG30790@tiger>
References: <1471964171-27480-1-git-send-email-Anson.Huang@nxp.com>
 <20160829061910.GG30790@tiger>
Message-ID: <20160829062720.GI30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 02:19:10PM +0800, Shawn Guo wrote:
> On Tue, Aug 23, 2016 at 10:56:11PM +0800, Anson Huang wrote:
> > On those i.MX6 platforms which have no speed grading
> > check, opp table will NOT be created in platform code,
> > so cpufreq driver will have below error message:
> > 
> > cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
> 
> The cpufreq driver calls dev_pm_opp_get_opp_count() to test if platform
> supplies an OPP table.  If not, the driver will call into
> dev_pm_opp_of_add_table() on its own.  So this is not an error message,
> and cpufreq driver should just work fine on i.MX6SX and i.MX6SL.

If you think the message might confuse people, we can add an info
message in cpufreq driver in case it adds OPP table by its own, which
can explain the 'error' message a bit from dev_pm_opp_get_opp_count().

Shawn

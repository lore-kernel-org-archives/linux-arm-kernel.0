From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jan 2014 22:44:21 +0100
Subject: [PATCH 20/73] arm: use subsys_initcall in non-modular pl320 IPC
 code
In-Reply-To: <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4922482.oeJaTIvZxl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 January 2014 16:22:23 Paul Gortmaker wrote:
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of subsys_initcall (which
> seems to make sense for netfilter code) will thus change this
> registration from level 6-device to level 4-subsys (i.e. slightly
> earlier).  However no impact of that small difference is expected.

This doesn't have anything to do with netfilter. The only user
of this driver at the moment is the highbank cpufreq driver, but
that could change.

	Arnd

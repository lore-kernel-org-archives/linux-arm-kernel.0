From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 16:03:41 +0000
Subject: [PATCH 3/9] amba: Keep PM domain powered during ->probe()
In-Reply-To: <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20150313160341.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:43:43PM +0100, Ulf Hansson wrote:
> To sucessfully probe some devices their corresponding PM domains may
> need to be powered.
> 
> Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
> domain.

Given that AMBA gets the runtime PM status across a probe, none of this
should be necessary, as generic PM domains ensures that if runtime PM
is active for any device bound to the PM domain, the PM domain will be
powered up.

In that respect, AMBA is a model of how runtime PM should've been done
for stuff like platform devices. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

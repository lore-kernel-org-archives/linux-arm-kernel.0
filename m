From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Jan 2013 12:35:15 -0700
Subject: [PATCH 1/2] ARM: tegra: clean up the CPUINIT section
In-Reply-To: <1357291942-32433-1-git-send-email-josephl@nvidia.com>
References: <1357291942-32433-1-git-send-email-josephl@nvidia.com>
Message-ID: <50E72EF3.5020200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 02:32 AM, Joseph Lo wrote:
> There are some redundant codes in the CPUINIT section that was caused by
> some codes not be organized well in "headsmp.S". Currently all the codes
> in "headsmp.S" were put into CPUINIT section. But actually it doesn't
> need to be loacted in CPUINIT section. There is no fuction access them
> in CPUINIT section and we will relocate them to IRAM.
> 
> These codes also caused some unnecessary functions that access these
> codes been put into CPUINIT section too. This patch clean it up and put
> them into normal text section.

Applied to Tegra's for-3.9/soc branch.

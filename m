From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Oct 2016 21:34:21 +0100
Subject: [PATCH v2 0/4] PXA cpufreq conversion to clock API
In-Reply-To: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161015203421.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 15, 2016 at 09:57:26PM +0200, Robert Jarzmik wrote:
> Hi,
> 
> This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
> API.
> 
> The first 3 patches are review and merge material :
>  - patch 1/4 for Viresh and Rafael
>  - patches 2/4 and 3/4 for me
> 
> The 4th on is for review but not merge, as the clock changes must be fully
> reviewed and go in first as a prequisite

Have you tested whether this patch set results in functional cpufreq
support - looking at drivers/clk/pxa, the CPU clock is read-only -
it can't be used to change the clock rate.  So, I very much doubt this
has been functionally tested.

Don't forget that changing the CPU clock rate needs other changes
(like the memory clock rate) so all that code you're removing in
patch 4 (which does the actual clock change) needs to go somewhere.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

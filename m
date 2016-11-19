From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 18:31:38 -0800
Subject: [GIT PULL 2/10] firmware: Add Tegra IVC and BPMP support
In-Reply-To: <20161118161719.24153-2-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
 <20161118161719.24153-2-thierry.reding@gmail.com>
Message-ID: <20161119023138.GL2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 05:17:11PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-firmware
> 
> for you to fetch changes up to b704ed8095ee91af5f3f7343bb3be23aae1cb26d:
> 
>   dt-bindings: firmware: Allow child nodes inside the Tegra BPMP (2016-11-18 14:33:44 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> firmware: Add Tegra IVC and BPMP support
> 
> IVC is an inter-processor communication protocol that uses shared memory
> to exchange data between processors. The BPMP driver makes use of this
> to communicate with the Boot and Power Management Processor (BPMP) and
> uses an additional hardware synchronization primitive from the HSP block
> to signal availability of new data (doorbell).
> 
> Firmware running on the BPMP implements a number of services such as the
> control of clocks and resets within the system, or the ability to ungate
> or gate power partitions.
> 
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()
> 
> Joseph Lo (3):
>       soc/tegra: Add Tegra186 support
>       dt-bindings: mailbox: Add Tegra HSP binding
>       dt-bindings: firmware: Add bindings for Tegra BPMP
> 
> Stephen Warren (2):
>       dt-bindings: Add power domains to Tegra BPMP firmware
>       dt-bindings: firmware: Allow child nodes inside the Tegra BPMP
> 
> Thierry Reding (5):
>       Merge branch 'for-4.10/soc' into for-4.10/mailbox
>       mailbox: Add Tegra HSP driver
>       Merge branch 'for-4.10/mailbox' into for-4.10/firmware
>       firmware: tegra: Add IVC library
>       firmware: tegra: Add BPMP support

Hi,

Again the format of the pull request here is a little confusing, since it's
a cumulative shotlog and diffstat, while you already sent the bulk of this
as part of the driver branch (1/10). It'd have been better to use that branch
as the base when you generate the pull request since that's the delta we see
when we merge it in.

Also, I can't seem to find the key you use to sign these tags with, it isn't
uploaded on pgp.mit.edu. Can you remedy that please, and get it signed as
needed?

All that being said, I've merged this into next/drivers. Thanks!


-Olof

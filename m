From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 Mar 2018 09:42:02 +0100
Subject: [GIT PULL 4/7] soc/tegra: Changes for v4.17-rc1
In-Reply-To: <20180316141850.4876-4-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
 <20180316141850.4876-4-thierry.reding@gmail.com>
Message-ID: <20180319084202.GA24307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 03:18:47PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-soc
> 
> for you to fetch changes up to 0cad0983bd3c002e92dff1e9d7f28c2c312c1973:
> 
>   soc/tegra: pmc: Use the new reset APIs to manage reset controllers (2018-03-09 08:51:07 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> soc/tegra: Changes for v4.17-rc1
> 
> This contains more Tegra194 support as well as an implementation for the
> MBIST workaround needed to avoid some memory-related issues on Tegra210.
> 
> ----------------------------------------------------------------
> Mikko Perttunen (2):
>       soc/tegra: Add Tegra194 SoC configuration option
>       soc/tegra: pmc: Add Tegra194 compatibility string
> 
> Peter De Schrijver (1):
>       soc/tegra: pmc: MBIST work around for Tegra210
> 
> Thierry Reding (1):
>       soc/tegra: pmc: Pass PMC to tegra_powergate_power_up()
> 
> Vivek Gautam (1):
>       soc/tegra: pmc: Use the new reset APIs to manage reset controllers

I'd like to update this pull request with this final patch fixed up. I
had to apply it manually and it looks like I messed it up. This has one
hunk missing that causes a failure to boot on Jetson TX1, but only if
neither DSI nor HDMI are enabled (DSI explicitly disabled in DT, and
HDMI not connected). I only stumbled on this because I was testing some
unrelated display code paths.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/0a01a84b/attachment.sig>

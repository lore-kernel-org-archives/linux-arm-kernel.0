From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 22:15:20 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
In-Reply-To: <20150511193527.GA29690@lukather>
References: <20150511193527.GA29690@lukather>
Message-ID: <2615254.66Y5XGdzL1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 May 2015 21:35:27 Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Here is the first batch of drivers changes for the 4.2 merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-4.2
> 
> for you to fetch changes up to 44bb362ff9f2e6f9ab285e66ce92f55aee71808a:
> 
>   drivers: soc: sunxi: Introduce SoC driver to map SRAMs (2015-05-05 20:47:08 +0200)
> 
> ----------------------------------------------------------------
> Allwinner drivers patches for 4.2
> 
> This pull request contain a single driver to handle the SRAM mapping
> between the CPU and devices.
> 

Hi Maxime,

Sorry I hadn't looked at the new driver before, but I did now and need a little
clarification. It seems to me that the device should be compatible with the
generic DT binding we have in Documentation/devicetree/bindings/misc/sram.txt,
and use more generic code. At least I can't see much in here that is really sunxi
specific.

Were you not aware of that generic binding, or did you have a good reason
not to use it? In the latter case, please document that in the patch description
(after replying here).

One small bug I found in the DT binding: the main DT node is lacking
a "ranges" property.

	Arnd

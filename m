From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Jun 2012 15:58:52 -0600 (MDT)
Subject: [PATCH v2 0/2] arm: omap3: am35x: Convert emac to hwmod & disable
 hlt when open
In-Reply-To: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1206271556490.27496@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> These patches convert the davinci emac support for the am35x SoC
> to use hwmod and add enable_hlt()/disable_hlt() calls to the
> pm_runtime hooks for that driver.
> 
> I have converted the davinci_emac driver to use pm_runtime but I
> can't formally submit it yet since it requires some changes on the
> mach-davinci side that haven't happened yet.  I will send it as an
> RFC in a reply to this thread.
> 
> The patches are based on:
>         git://git.pwsan.com/linux-2.6 am35xx_hwmod_data_fixes_a_3.5
> 
> Changes from v1:
> - patch 1/2, "arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod support"
>   is unchanged
> - patch 2/2, "arm: "omap3: am35x: Disable hlt when using Davinci EMAC"
>   has been reworked to keep the code as simple as possible per
>   http://www.spinics.net/lists/linux-omap/msg70354.html

The updated patches that were just reposted today have been queued for 
3.6, along with a few comments about the IPSS issue, mentioned earlier. 
They can be found in the branch am35xx_emac_mdio_devel_3.6 in 
git://git.pwsan.com/linux-2.6.  Please let me know if you have any 
comments.


- Paul

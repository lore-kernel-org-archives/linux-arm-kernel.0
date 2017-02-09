From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2017 09:55:34 +0000
Subject: [PATCHv3 net-next 00/12] net: mvpp2: misc improvements and
 preparation patches
In-Reply-To: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170209095534.GB27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 04:51:29PM +0100, Thomas Petazzoni wrote:
> David,
> 
> This series contains a number of misc improvements and preparation
> patches for an upcoming series that adds support for the new PPv2.2
> network controller to the mvpp2 driver.
> 
> Sorry for the long delay since v2, I was on
> vacation/conference/training in January, and therefore wasn't able to
> resend a new version earlier. Upcoming versions should arrive much
> faster, if there are further comments on this series.
> 
> The most significant improvements are:
> 
>  - Switching to using build_skb(), which is necessary for the upcoming
>    PPv2.2 support, but anyway a good improvement to the current mvpp2
>    driver (supporting PPv2.1).
> 
>  - Making the driver build on 64-bit platforms.
> 
> Changes since v2:
> 
>  - Fix remaining 64-bit build warning, reported by David Miller.
> 
>  - Adjust how bit mask related definitions are done in "net: mvpp2:
>    simplify MVPP2_PRS_RI_* definitions" according to Russell King
>    suggestions.
> 
>  - Add a patch "net: mvpp2: remove useless arguments in
>    mvpp2_rx_{pkts,time}_coal_set", suggested by Russell King.
> 
>  - Rework mvpp2_rx_time_coal_set() implementation to avoid overflows
>    and rounding errors. I've used the implementation suggested by
>    Russell King.
> 
> Changes since v1:
> 
>  - This series is split as a separate series from the larger patch set
>    adding support for PPv2.2 in the mvpp2 driver, as requested by
>    David Miller.
> 
>  - Rebased on top of v4.10-rc1.

For the whole series:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

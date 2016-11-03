From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 3 Nov 2016 09:24:13 +0100
Subject: [PATCH 0/3] fix ohci phy name
In-Reply-To: <20161102124435.31777-1-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
Message-ID: <CAKXjFTPiL6K8g2KuFrq9rKJpViVaGPuBDBFSKk9bjqjY3Zd5Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar, David,

It might make sense to have this patch series,
squashed into a single patch, would you agree,
or do you prefer it as is: one-per-subsystem?

Regards
Axel.

On Wed, Nov 2, 2016 at 1:44 PM, Axel Haslam <ahaslam@baylibre.com> wrote:
> The usb ohci clock match is not working because the usb clock
> is registered as "ohci" instead of "ohci.0"
>
> But since there is only a single ohci instance, lets pass -1 to
> the platform data id parameter and avoid the extra ".0" matching.
>
> while we are fixing this, rename the driver to "ohci-da8xx" to be
> consistent with davinci musb and other usb drivers.
>
> Axel Haslam (3):
>   ARM: davinci: da8xx: Fix ohci driver name
>   phy: da8xx-usb: rename the ohci device to ohci-da8xx
>   usb: ohci-da8xx: rename driver to ohci-da8xx
>
>  arch/arm/mach-davinci/da830.c     | 2 +-
>  arch/arm/mach-davinci/da850.c     | 2 +-
>  arch/arm/mach-davinci/da8xx-dt.c  | 2 +-
>  arch/arm/mach-davinci/usb-da8xx.c | 4 ++--
>  drivers/phy/phy-da8xx-usb.c       | 5 +++--
>  drivers/usb/host/ohci-da8xx.c     | 2 +-
>  6 files changed, 9 insertions(+), 8 deletions(-)
>
> --
> 2.10.1
>

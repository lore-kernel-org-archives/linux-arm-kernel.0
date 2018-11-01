From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Nov 2018 15:58:13 +0800
Subject: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
In-Reply-To: <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-7-jagan@amarulasolutions.com>
 <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
Message-ID: <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 3:35 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > From: Jagan Teki <jagan@openedev.com>
> >
> > Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> > - WiFi SDIO interface is connected to MMC1
> > - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> > - WiFi WL-WAKE-AP pin connected to gpio PM0
> > - 32kHz external oscillator gate clock from RTC

You never specified a clock rate for it, so it might actually be wrong.
The default clock rate would be something "around" 32 kHz, but not very
accurate. Meanwhile the WiFi module would have very specific requirements
on frequency and accuracy of this clock. The WiFi part doesn't seem to
care that much, but the Bluetooth part cares very much. It doesn't work
or it would seem to work but you don't get anything off the radio if the
frequency is off (as in off-frequency).

> >
> > Signed-off-by: Jagan Teki <jagan@openedev.com>
> > ---
> > Note:
> > - chip detected, but failed to connect
> > [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> > [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>
> This got fixed. Will send next version.

Could you wait until I get my RTC changes out? I also have some Bluetooth
patches for AP621x, which is what started all this RTC work, which you might
find interesting.

ChenYu

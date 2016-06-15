From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Jun 2016 09:40:41 -0700
Subject: [PATCH v2 07/11] mmc: sdhci-of-arasan: Add ability to export card
 clock
In-Reply-To: <1465859076-4868-8-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-8-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=UH+5bs8TUe+nOKnmEsYL+7iF2JkKri2kzRgHYpyDLK1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 13, 2016 at 4:04 PM, Douglas Anderson <dianders@chromium.org> wrote:
> Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
> with arasan,sdhci-5.1) need to know the card clock in order to function
> properly.  Let's add the ability to expose this clock.  Any PHY that
> needs to know the clock rate can add a reference and query the clock
> rate.
>
> At the moment we register a CLK_GET_RATE_NOCACHE clock that simply
> allows querying the clock.  This allows us to be less intrusive with
> regards to the main SDHCI driver, which has complex logic for adjusting
> the SD clock.  Right now we always fully power cycle the PHY when the
> clock changes and that gives the PHY a good chance to query our clock.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-arasan.c | 125 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 3 deletions(-)

I've sent out a new version of just this patch as "version 2.1" to
address a problem found by Guenter Roeck.  Please see
<https://patchwork.kernel.org/patch/9178951/>.  If it's handy for me
to send out a whole new v3 series, please let me know.

-Doug

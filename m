From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Dec 2015 00:48:36 +0100
Subject: [PATCH v1 0/6] Support the rk3036 Kylin board
In-Reply-To: <CAGXu5jKEykL1+F=m2kk8E4qOKeUmc-jHnZ-fYpz1OS8oQ1Pgxg@mail.gmail.com>
References: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
 <CAGXu5jKEykL1+F=m2kk8E4qOKeUmc-jHnZ-fYpz1OS8oQ1Pgxg@mail.gmail.com>
Message-ID: <2077620.agNLOx8o2g@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar, Kees,

Am Donnerstag, 17. Dezember 2015, 11:45:06 schrieb Kees Cook:
> On Thu, Dec 17, 2015 at 6:21 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> > Kylin-board is based on RK3036 SOCs, add the initiation
> > version for working.
> > 
> > This series patches have the following decriptions:
> > 
> > PATCH[1/6]:
> > ARM: dts: fix the correct pinctrl control for rk3036
> > 
> > The pinctrl gpio pull up/down is incorrect since the rk3036 SoCs
> > can't set the status in the internal.
> > ---
> > 
> > PATCH[2/6]:
> > ARM: dts: add the lcdc and hdmi node for rk3036
> > 
> > Add the devices is related to display.
> > Based on the series patches of Mark Yao's
> > ---
> > 
> > PATCH[3/6]:
> > ARM: dts: add the sdio/sdmmc node for rk3036
> > 
> > Add the wifi/sd card work for kylin board.
> > ---
> > 
> > PATCH[4/6]:
> > ARM: dts: rockchip: add the kylin board for rk3036
> > 
> > Add the dts for kylin board.
> > ---
> > 
> > PATCH[5/6]:
> > ARM: dts: add the sound codec for kylin board
> > 
> > Make the codec rt5616 working on kylin board.
> > The realteak have been upstream for Mark Brown,
> > I guess need some days to review.
> > 
> > ---
> > 
> > PATCH[6/6]:
> > ARM: dts: add the sdio node for kylin board
> > 
> > Enable the sdio for kylin board.
> > ---
> 
> Thanks for sending this!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Some thoughts: maybe collapse 4, 5, and 6 together, since it's a new file?

@Caesar, no need to resend, I can do that merging myself.
After we clarified the authorship of patch1 ;-) .

Except the audio patch, as we're missing the realtek codec driver.
I'll also drop the lcdc+hdmi parts for now, as the relevant parts aren't in
any maintainer-tree yet. The ordering is for this:

- atomic conversion
- rk3036 vop
- inno-hdmi driver
- dts changes last

The driver for the Innosilicon hdmi driver is from November, had one comment 
from me and Caesar+ Yakir should make sure it works with the atomic 
modesetting variant of the drm/kms driver please. (And probably resend the 
series fixing that one tiny comment).


Heiko

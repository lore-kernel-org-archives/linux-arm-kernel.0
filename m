From: dianders@chromium.org (Doug Anderson)
Date: Fri, 25 Jul 2014 08:08:27 -0700
Subject: [PATCH v2 1/4] ARM: dts: exynos5250: max77686 is Snow only
In-Reply-To: <08fe01cfa7c9$341cc700$9c565500$@samsung.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-2-git-send-email-afaerber@suse.de>
 <08fe01cfa7c9$341cc700$9c565500$@samsung.com>
Message-ID: <CAD=FV=VUkU7HWjwCKO=WOrKosUtmv3YE_8pxc5uoQg0cHr-AKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 24, 2014 at 10:28 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Andreas F?rber wrote:
>>
>> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
>> Spring does not need it, it uses an s5m8767 instead.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>
> Hi Andreas,
>
> I think this should be reviewed by chrome guys.
>
>
> Doug, can you have a look this series for exynos5250-chromebook?
> I'm not sure exynos5250-cros-common is still useful for exynos5250-spring...

Sorry, I've been on vacation and am now playing catchup.

Right.  The current suggestion is to rework to just duplicate things
and don't use exynos5250-cros-common.  I would structure the series
as:

1. Fold the current exynos5250-cros-common directly into the snow
device tree file.

2. If desired, cleanup the snow device tree file.

3. Create the spring device tree file based on snow.  There will be
duplication, but so be it.  Please try to minimize diffs between the
snow ad spring device tree files.

4. If possible, identify "fragments" like "cros-ec-keyboard.dtsi" and
factor them out of both spring and snow device tree files.


You could certainly reorder some of the above steps if you wish (you
could split out fragments before creating the spring device tree, for
instance).


Please make sure to CC Javier (now on CC) since he's helping with
Chromebook upstreaming and he may have a lower latency in responding
than I do.

-Doug

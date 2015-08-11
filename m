From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 11 Aug 2015 12:28:41 +0800
Subject: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable wdt
 if enabled
In-Reply-To: <1488521.5eJqASov2O@ubix>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
 <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
 <1488521.5eJqASov2O@ubix>
Message-ID: <CAGS+omD1UYSTfJ4-vZSE_BYuvGcTvpbC7T4ukaV10xuQxkCChg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter, Matthias,

On Fri, Jul 24, 2015 at 1:37 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On Thursday, July 23, 2015 01:49:11 PM Eddie Huang wrote:
>> From: Greta Zhang <greta.zhang@mediatek.com>
>>
>> Without .shutdown(), watchdog might reset the system during power off.
>> For example, if watchdog's timeout is set to 30s, then it is reset to
>> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
>> but watchdog is still running and may trigger reset.
>>
>> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> ---
>>  drivers/watchdog/mtk_wdt.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

is the plan to land these two patches via Guenter's watchdog tree [0]?
[0] git://www.linux-watchdog.org/linux-watchdog.git

In fact, though, I don't see any new patches in that repository.
The only branches I see are:
  remotes/wdog/master                                      b953c0d Linux 4.1
  remotes/wdog/winbond-superio                             dc89871
Sample Winbond Super-I/O MFD device consisting out of a lowel-level
driver that does the detection and creates the platform-data and a
watchdog driver.

Am I looking in the wrong place?

-Dan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

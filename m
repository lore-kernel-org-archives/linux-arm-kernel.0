From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 10 Aug 2015 21:42:20 -0700
Subject: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable
 wdt if enabled
In-Reply-To: <CAGS+omD1UYSTfJ4-vZSE_BYuvGcTvpbC7T4ukaV10xuQxkCChg@mail.gmail.com>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
 <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
 <1488521.5eJqASov2O@ubix>
 <CAGS+omD1UYSTfJ4-vZSE_BYuvGcTvpbC7T4ukaV10xuQxkCChg@mail.gmail.com>
Message-ID: <55C97D2C.6090505@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 09:28 PM, Daniel Kurtz wrote:
> Hi Guenter, Matthias,
>
> On Fri, Jul 24, 2015 at 1:37 AM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> On Thursday, July 23, 2015 01:49:11 PM Eddie Huang wrote:
>>> From: Greta Zhang <greta.zhang@mediatek.com>
>>>
>>> Without .shutdown(), watchdog might reset the system during power off.
>>> For example, if watchdog's timeout is set to 30s, then it is reset to
>>> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
>>> but watchdog is still running and may trigger reset.
>>>
>>> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>>> ---
>>>   drivers/watchdog/mtk_wdt.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>
>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> is the plan to land these two patches via Guenter's watchdog tree [0]?
> [0] git://www.linux-watchdog.org/linux-watchdog.git
>
That is Wim's tree, and Wim is the maintainer ;-).

I have the patches queued in my tree [1], and I plan to send a pull request
to Wim this week or early next week.

Guenter

---
[1] https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next

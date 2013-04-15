From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 15 Apr 2013 15:44:51 -0700
Subject: [PATCH] PM / Runtime: Improve prepare handling at system suspend
 for genpd
In-Reply-To: <1844674.ZBv3XGts1U@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Fri, 12 Apr 2013 13:50:36 +0200")
References: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
 <1844674.ZBv3XGts1U@vostro.rjw.lan>
Message-ID: <87vc7n8lcs.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, April 12, 2013 11:41:44 AM Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> 
>> When genpd prepares for a system suspend it will fetch a runtime
>> reference for the device. When returning it we now use the
>> asyncronous runtime PM API. Thus we don't have to wait for the
>> device to become idle|suspended before we move on and handle the
>> next device in queue.
>> 
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>
> All three patches applied to linux-pm.git/linux-next.

In case it matters, for all three:

Reviewed-by: Kevin Hilman <khilman@linaro.org>

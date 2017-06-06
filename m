From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Tue, 6 Jun 2017 22:05:03 +0200
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <20170606192554.GA32171@amd>
References: <1496716596-45414-1-git-send-email-bo.zhang@nxp.com>
 <20170606192554.GA32171@amd>
Message-ID: <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2017 09:25 PM, Pavel Machek wrote:
> On Tue 2017-06-06 10:36:36, Zhang Bo wrote:
>> System cannot enter suspend mode because of heartbeat led trigger.
>> In autosleep_wq, try_to_suspend function will try to enter suspend
>> mode in specific period. it will get wakeup_count then call pm_notifier
>> chain callback function and freeze processes.
>> Heartbeat_pm_notifier is called and it call led_trigger_unregister to
>> change the trigger of led device to none. It will send uevent
> 
> Why is heartbeat_pm_notifier calling led_trigger_unregister? That
> sounds like a bug.

I suggest using git blame. The commit message adding this code is pretty
informative.

-- 
Best regards,
Jacek Anaszewski

From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Jun 2017 22:38:13 +0200
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <8afffd09-cb1f-d080-ef4a-ecaa089ad470@ti.com>
References: <1496716596-45414-1-git-send-email-bo.zhang@nxp.com>
 <20170606192554.GA32171@amd>
 <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
 <8afffd09-cb1f-d080-ef4a-ecaa089ad470@ti.com>
Message-ID: <20170606203813.GD32171@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-06-06 15:19:23, Grygorii Strashko wrote:
> 
> 
> On 06/06/2017 03:05 PM, Jacek Anaszewski wrote:
> > On 06/06/2017 09:25 PM, Pavel Machek wrote:
> >> On Tue 2017-06-06 10:36:36, Zhang Bo wrote:
> >>> System cannot enter suspend mode because of heartbeat led trigger.
> >>> In autosleep_wq, try_to_suspend function will try to enter suspend
> >>> mode in specific period. it will get wakeup_count then call pm_notifier
> >>> chain callback function and freeze processes.
> >>> Heartbeat_pm_notifier is called and it call led_trigger_unregister to
> >>> change the trigger of led device to none. It will send uevent
> >>
> >> Why is heartbeat_pm_notifier calling led_trigger_unregister? That
> >> sounds like a bug.
> > 
> > I suggest using git blame. The commit message adding this code is pretty
> > informative.
> > 
> 
> In my opinion original commit do not contain ehough info about root cause 
> of the problem (commit 5ab92a7cb "leds: handle suspend/resume in
> heartbeat trigger")

Zhang: Can you try to revert commit 5ab92a7cb in your tree, to see if
it fixes your problem?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/ba7cafed/attachment.sig>

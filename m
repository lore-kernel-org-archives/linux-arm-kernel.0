From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jun 2017 11:35:22 +0200
Subject: [[PATCH]] Revert "leds: handle suspend/resume in heartbeat
 trigger"
In-Reply-To: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
References: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
Message-ID: <CACRpkdY6-REXoXjWNUrfCuPn3GYHhV0di7Lhbb=wRhBtPC0+mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 4:39 AM, Zhang Bo <bo.zhang@nxp.com> wrote:

> This reverts commit 5ab92a7cb82c66bf30685583a38a18538e3807db.
>
> System cannot enter suspend mode because of heartbeat led trigger.
> In autosleep_wq, try_to_suspend function will try to enter suspend
> mode in specific period. it will get wakeup_count then call pm_notifier
> chain callback function and freeze processes.
> Heartbeat_pm_notifier is called and it call led_trigger_unregister to
> change the trigger of led device to none. It will send uevent message
> and the wakeup source count changed. As wakeup_count changed, suspend
> will abort.
>
> Signed-off-by: Zhang Bo <bo.zhang@nxp.com>

OK I was stupid, lesson learned.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 24 Feb 2014 15:09:38 +0800
Subject: [PATCH RFC v1 2/3] Fix hibernation restore hang in
 freeze_processes
In-Reply-To: <1392774729-3235-3-git-send-email-sebastian.capella@linaro.org>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-3-git-send-email-sebastian.capella@linaro.org>
Message-ID: <CACVXFVMN_uijYRj9CCKHbnM40YVyp8ar7mp4g=s70gv8YmFCLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 9:52 AM, Sebastian Capella
<sebastian.capella@linaro.org> wrote:
> During restore, pm_notifier chain are called with
> PM_RESTORE_PREPARE.  The firmware_class driver handler
> fw_pm_notify does not have a handler for this.  As a result,
> it keeps a reader on the kmod.c umhelper_sem.  During
> freeze_processes, the call to __usermodehelper_disable tries to
> take a write lock on this semaphore and hangs waiting.
>
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Russ Dill <Russ.Dill@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Ming Lei <ming.lei@canonical.com>

Thanks,
--
Ming Lei

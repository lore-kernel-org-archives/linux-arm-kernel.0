From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 15:18:29 -0300
Subject: i.MX53 restart via watchdog does not work
In-Reply-To: <571654B0.6040203@nxtcontrol.com>
References: <57111429.6040802@nxtcontrol.com>
 <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
 <571654B0.6040203@nxtcontrol.com>
Message-ID: <CAOMZO5AxUcjDLo6afdFTkZJv9QnsUvHWwcJmsno3o52DqipN-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 12:54 PM, Stanislav Meduna
<stanislav.meduna@nxtcontrol.com> wrote:

> After much head-scratching I was able to isolate the problem.
> In fact it has nothing to do with the watchdog or at least
> not directly. The reset is now located in the watchdog
> code itself and gets called normally (which I have
> overlooked when writing the original message).
>
> The probable culprit is the eMMC card being left in some
> state that the bootloader cannot handle. For now I worked
> around it using the patch below (4.4-based), using a device
> tree property to prevent the card from sleeping
> in _mmc_suspend.
>
> I'm not really sure what the 3.9 kernel does differently
> here though...
>
> Could you try to jump around the mmc_sleep(host)
> call in _mmc_suspend to see whether it fixes the problem
> also for you?

Looks like we are having different issues. Just tested on a imx53-qsb
board and it reboots fine with 4.6-rc4.

I am booting via NFS, so not eMMC related.

I will investigate the mx6ul-evk issue.

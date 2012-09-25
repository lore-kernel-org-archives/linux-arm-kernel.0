From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 25 Sep 2012 17:59:52 +0530
Subject: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
In-Reply-To: <20120919115933.GJ3772@arwen.pp.htv.fi>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
 <20120918140213.GA27463@arwen.pp.htv.fi>
 <CANOLnONC1oDN3yu=ipao2A6MfuSkZfROVPewWLLEM5fNTKipxQ@mail.gmail.com>
 <20120919115933.GJ3772@arwen.pp.htv.fi>
Message-ID: <CAJe_Zhc5jCBcfvTcs=Xi_QXLU+t_Erck-3pxV5co1xAsjj8kkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2012 17:29, Felipe Balbi <balbi@ti.com> wrote:

> this is what I mean, actually. If we remove pm_runtime_get_sync() in
> exchange for pm_runtime_set_active() before pm_runtime_enable(), it
> works on PandaBoard, but breaks BeagleBoard.
>
Perhaps it suggests that OMAP4 (PandaBoard) serial port is already
activated but OMAP3 (BeagleBoard) isn't. So we need to reflect that
either by doing pm_runtime_set_active() only on OMAP4 or by bringing
up the OMAP3 too before the pm_runtime_set_active() call.
BTW I understand get_sync(), set_active() and enable() are for
different purposes, they can't be traded for one another.

From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 Dec 2015 09:26:55 -0200
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
Message-ID: <CAOMZO5CfBKuJ584jwbg98s9tn+0Z7W0nOaZnUkm4cJUSvNGTZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Dec 14, 2015 at 5:26 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Hi all,
>
> There is a known issue that the USB code can't handle USB HUB's
> external pins well, in that case, it may cause some onboard
> USB HUBs can't work since their PHY's clock or reset pin needs to
> operate.
>
> The user reported this issue at below:
> http://www.spinics.net/lists/linux-usb/msg131502.html
>
> In this patch set, I add a generic onboard USB HUB driver to
> handle this problem, the external signals will be configured
> before usb controller's initialization, it much likes we did
> it at board code before.
>
> The user needs to add this generic hub node at dts to support it.
>
> @The udoo users, help to test please.

This is what I get with your series applied:

[    2.288300] usb 1-1: device descriptor read/64, error -71
[    2.518083] usb 1-1: new full-speed USB device number 3 using ci_hdrc
[    2.738078] usb 1-1: device descriptor read/64, error -71
[    3.058078] usb 1-1: device descriptor read/64, error -71
[    3.288079] usb 1-1: new full-speed USB device number 4 using ci_hdrc
[    3.768069] usb 1-1: device not accepting address 4, error -71
[    3.888084] usb 1-1: new full-speed USB device number 5 using ci_hdrc
[    4.368067] usb 1-1: device not accepting address 5, error -71
[    4.374117] usb usb1-port1: unable to enumerate USB device

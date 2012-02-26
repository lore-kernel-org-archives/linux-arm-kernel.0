From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 26 Feb 2012 17:55:09 +0300
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <20120226142703.GN22562@n2100.arm.linux.org.uk>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
 <20120226142703.GN22562@n2100.arm.linux.org.uk>
Message-ID: <CA+E=qVfyr9FXtwL6kzrDjOoLW7vQTXJPoDrLobnk9NmdTpy25w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
>> Bootloader can clobber PWER value, so save it state on suspend.
>
> What boot loader is this, and why is it being so idiotic? ?Why can't it
> be fixed?

I'm using u-boot on this machine...
Hmm, I've looked throuhg its sources and did not find where it can clobber it.
But PWER register value is not preserved across suspend for some reason
(at least bit 0). Maybe it's some conflict with gpiolib? But
gpio_set_wake() doesn't work
for me on PXA.

Regards
Vasily

From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Apr 2018 18:32:42 +0200
Subject: [v3,4/4] watchdog: add Gateworks System Controller support
In-Reply-To: <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net>
 <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
 <20180330181954.GA17580@roeck-us.net>
 <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
Message-ID: <20180402163242.GC14165@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The 'use case' we have been using this in for a couple years is that
> users who want to use this watchdog will enable it externally (we have
> a command in the bootloader) and if enabled the kernel driver (that
> I'm proposing here which we've been using out-of-tree) will register
> the watchdog device and the userspace watchdog process can open the
> device and start tickling it. If the watchdog is never enabled (or
> disabled via the bootloader command) the kernel driver fails to probe
> and the SoC's watchdog can be used.

Hi Tim

Is there any reason not to give the user the choice to use both
watchdogs? Normally you write drivers to expose the hardware, and then
let the users choice if they want to use it.

	Andrew

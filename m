From: johan@kernel.org (Johan Hovold)
Date: Tue, 21 Aug 2018 16:29:10 +0200
Subject: serdev: How to attach serdev devices to USB based tty devices?
In-Reply-To: <20180815182150.wsd5oxlucsox2qig@earth.universe>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
 <20180815182150.wsd5oxlucsox2qig@earth.universe>
Message-ID: <20180821142910.GJ14967@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2018 at 08:21:50PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> +cc Johan Hovold <johan@kernel.org>
> 
> Johan told me, that he is working on this at ELCE 2017. Also he is
> the subsystem maintainer of the USB serial subsystem.

I haven't done much work on this; it's more of a low-priority background
task that keeps popping up. ;)

Rob already linked to Ricardo's series in which this was recently
discussed [1][2].

In one of those threads I also posted to some code I've been using to
test serdev with USB-serial devices [3]. There are some known issues
blocking this from being merged (e.g. serdev not supporting hangups and
agreement on DT bindings), but it would otherwise allow you to use
serdev for fixed topologies (i.e. you know beforehand which port you'll
be plugging your USB-serial device into). So that might still be useful
for development purposes as is.

With DT-overlay support this could be extended also to the dynamic case
(e.g. loading overlays from userspace or passing the equivalent data
from a tty driver).

Johan


[1] https://lkml.kernel.org/r/CAPybu_0RRNMsdzv4CKyw922hX3_EF=-LKD_QWZV0DoQmjG0aRQ at mail.gmail.com
[2] https://lkml.kernel.org/r/20180611115240.32606-1-ricardo.ribalda at gmail.com
[3] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of

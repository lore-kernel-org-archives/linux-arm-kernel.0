From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 9 Nov 2014 13:49:19 +0100
Subject: tsc2005 touchscreen: implement disable attribute
In-Reply-To: <20141109124025.GA21763@earth.universe>
References: <20141109115636.GA3106@amd> <20141109124025.GA21763@earth.universe>
Message-ID: <201411091349.20116@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 November 2014 13:40:25 Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Nov 09, 2014 at 12:56:37PM +0100, Pavel Machek wrote:
> > Implement disable attribute for tsc2005 touchscreen. It is
> > useful to avoid wakeups when phone is in the pocket.
> 
> I don't think this should be some driver specific sysfs node.
> Instead a generic method from the input subsystem should be
> used.
> 
> -- Sebastian

Yes. I would like to see generic method to turn off input device 
(or just "mute" it if device does not support turn off). Similar 
problem is also on laptops or other portable devices. E.g when I 
close LID of my laptop I want to turn off internal input devices 
(keyboard, touchpad, trackstick) without need to unload evdev 
Xserver drivers (or killing Xserver). Another use case is to turn 
off keyboard (also from kernel tty on Ctrl+Alt+Fx) which cannot 
be unplugged (internal laptop keyboard).

CCed Dmitry, what do you think about it?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141109/867a9e56/attachment.sig>

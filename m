From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 10 Nov 2014 10:14:23 +0100
Subject: tsc2005 touchscreen: implement disable attribute
In-Reply-To: <20141109200142.GA37384@dtor-ws>
References: <20141109115636.GA3106@amd> <201411091349.20116@pali>
 <20141109200142.GA37384@dtor-ws>
Message-ID: <201411101014.25873@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 November 2014 21:01:42 Dmitry Torokhov wrote:
> On Sun, Nov 09, 2014 at 01:49:19PM +0100, Pali Roh?r wrote:
> > On Sunday 09 November 2014 13:40:25 Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Sun, Nov 09, 2014 at 12:56:37PM +0100, Pavel Machek 
wrote:
> > > > Implement disable attribute for tsc2005 touchscreen. It
> > > > is useful to avoid wakeups when phone is in the pocket.
> > > 
> > > I don't think this should be some driver specific sysfs
> > > node. Instead a generic method from the input subsystem
> > > should be used.
> > > 
> > > -- Sebastian
> > 
> > Yes. I would like to see generic method to turn off input
> > device (or just "mute" it if device does not support turn
> > off). Similar problem is also on laptops or other portable
> > devices. E.g when I close LID of my laptop I want to turn
> > off internal input devices (keyboard, touchpad, trackstick)
> > without need to unload evdev Xserver drivers (or killing
> > Xserver). Another use case is to turn off keyboard (also
> > from kernel tty on Ctrl+Alt+Fx) which cannot be unplugged
> > (internal laptop keyboard).
> > 
> > CCed Dmitry, what do you think about it?
> 
> Actually I'd like it to be not limited to input devices but
> rater try doing it at the device core level, if possible. I
> am sure there are IIO and other devices that could be
> forcibly turned off/put into low power mode under certain
> circumstances.
> 
> There were some talks about it with Rafael, but we never come
> with anything concrete.
> 
> Thanks.

Ok. What about adding sysfs node disable which accept value 0/1?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/eaa42bf7/attachment.sig>

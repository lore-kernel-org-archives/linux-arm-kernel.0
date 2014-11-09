From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 9 Nov 2014 12:01:42 -0800
Subject: tsc2005 touchscreen: implement disable attribute
In-Reply-To: <201411091349.20116@pali>
References: <20141109115636.GA3106@amd> <20141109124025.GA21763@earth.universe>
 <201411091349.20116@pali>
Message-ID: <20141109200142.GA37384@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 01:49:19PM +0100, Pali Roh?r wrote:
> On Sunday 09 November 2014 13:40:25 Sebastian Reichel wrote:
> > Hi,
> > 
> > On Sun, Nov 09, 2014 at 12:56:37PM +0100, Pavel Machek wrote:
> > > Implement disable attribute for tsc2005 touchscreen. It is
> > > useful to avoid wakeups when phone is in the pocket.
> > 
> > I don't think this should be some driver specific sysfs node.
> > Instead a generic method from the input subsystem should be
> > used.
> > 
> > -- Sebastian
> 
> Yes. I would like to see generic method to turn off input device 
> (or just "mute" it if device does not support turn off). Similar 
> problem is also on laptops or other portable devices. E.g when I 
> close LID of my laptop I want to turn off internal input devices 
> (keyboard, touchpad, trackstick) without need to unload evdev 
> Xserver drivers (or killing Xserver). Another use case is to turn 
> off keyboard (also from kernel tty on Ctrl+Alt+Fx) which cannot 
> be unplugged (internal laptop keyboard).
> 
> CCed Dmitry, what do you think about it?

Actually I'd like it to be not limited to input devices but rater try
doing it at the device core level, if possible. I am sure there are IIO
and other devices that could be forcibly turned off/put into low power
mode under certain circumstances.

There were some talks about it with Rafael, but we never come with
anything concrete.

Thanks.

-- 
Dmitry

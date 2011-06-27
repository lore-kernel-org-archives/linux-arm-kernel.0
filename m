From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 27 Jun 2011 22:39:07 +0200
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <Pine.LNX.4.44L0.1106250758250.1039-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1106250758250.1039-100000@netrider.rowland.org>
Message-ID: <4E08EA6B.90302@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2011 02:02 PM, Alan Stern wrote:
> Nevertheless...  The fact that the kernel can do nothing about a
> disconnected cable shouldn't stop us from handling system sleep
> correctly.  After all, the kernel _can_ do something about that.

Well, it depends of which level of driver we speek about.
I was speeking about UDC driver, ie. a hardware driver. My point was 
that the hardware driver should only care about the hardware register 
manipulations, and check their success. If they succeed, then it should 
suspend itself without care of filesystem not in sync.

I didn't meant that the filesystem driver shouldn't care about the 
suspend, or even the mass-storage gadget. I don't have a strong opinion 
on these higher levels. The question if the kernel can do something 
about it is much more complicated :
  - should userspace sync/umount and check filesystem before suspending 
(as umount usb storage before suspending)
  - should the kernel block a suspend because a usb key was "forgotten" 
in an USB slot ?

For these questions, I'll let others battle. For the hardware related 
drivers, I'm pretty convinced all they should care about is the success 
or failure of hardware suspend manipulation, and the correct suspend order.

Cheers.

--
Robert

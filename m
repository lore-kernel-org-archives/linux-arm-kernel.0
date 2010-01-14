From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 14 Jan 2010 08:28:02 +0100
Subject: [PATCH] RFC: mx27: Add soc_camera support
In-Reply-To: <37367b3a1001131033u74c30ad6q8da1dbc35982e008@mail.gmail.com>
References: <1260885686-8478-1-git-send-email-acassis@gmail.com>
	<37367b3a0912150607v713edc32y3578fa2a0c8c61db@mail.gmail.com>
	<eedb5541001032340n66205fb8s57e09d2ba413b322@mail.gmail.com>
	<37367b3a1001040412k280f3366p4868e36f5a7f71e4@mail.gmail.com>
	<eedb5541001040425h2a3c07dcn534c71a0918b322b@mail.gmail.com>
	<eedb5541001040431j3f14ec55g66ed4dd44a2a840e@mail.gmail.com>
	<37367b3a1001131033u74c30ad6q8da1dbc35982e008@mail.gmail.com>
Message-ID: <eedb5541001132328w3e1f1a4dj48e20bbad63acf96@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Unfortunately my camera is not responding to I2C commands, I already
> slow it down to 10kbps with no success. I can see on oscilloscope
> i.MX27 send I2C commands, but the camera doesn't respond to it.
>

No idea what can be causing this. Maybe I2C address is bad in board specific
code?


> Then I tested using the MT9T31 driver and change the it to my I2C
> commands, as I2C is failing I force the probe to return 0. But the
> soc_camera still failing:
>
> Linux video capture interface: v2.00
> write: -5
> MT9T31 Read register 0xFF = -5
> Forcing mt9t031_video_probe to return OK!
> mx27-camera mx27-camera.0: initialising
> mx27-camera: probe of mx27-camera.0 failed with error -2
>

As far as I know, video buffers are allocated in probe() function. Maybe you
have a memory fragmentation problem and you need to move buffer allocation
to init().
We have faced this problem many times in the past.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100114/ba02bb26/attachment-0001.htm>

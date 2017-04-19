From: rebothenebo@outlook.com (Ross McCormack)
Date: Wed, 19 Apr 2017 10:22:29 +0000
Subject: atmel-hlcdc-display-controller atmel-hlcdc-dc: No connectors reported
 connected with modes
Message-ID: <VI1P18901MB001332E3589D86DD115C4CC0B9180@VI1P18901MB0013.EURP189.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just tried to display the Linux Tux Logo at bootup of the SAM5D, but it won't show up. My display is 800x480, kernel version is 4.9.20. Appart from the display/drm stack the kernel works like a charm. I narrowed the problem down to this error:

atmel-hlcdc-display-controller atmel-hlcdc-dc: failed to create HLCDC outputs: -517
atmel-hlcdc-display-controller atmel-hlcdc-dc: failed to initialize mode setting
atmel-hlcdc-display-controller atmel-hlcdc-dc: No connectors reported connected with modes
[drm] Cannot find any crtc or sizes - going 1024x768
Console: switching to colour frame buffer device 128x48
atmel-hlcdc-display-controller atmel-hlcdc-dc: fb0:  frame buffer device

Now I tried video=Unknown-1:800x480-16 as suggested on [1] but it still shows the error.

What's the problem here? Is it a driver issue with the display?

[1] http://www.at91.com/linux4sam/bin/view/Linux4SAM/UsingAtmelDRMDriver

From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 12 Jan 2012 08:15:09 +0100
Subject: [RFC] ARM: imx: Add imx6q thermal
In-Reply-To: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
References: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
Message-ID: <4F0E887D.2090009@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 11.01.2012 08:18, Robert Lee wrote:
> Add thermal support for i.MX6Q.  Uses recently submitted common
> cpu_cooling functionality shown here:
> 
> http://www.spinics.net/lists/linux-pm/msg26500.html
> 
> Have some todo items but basic implementation is done and I'd like to
> get any helpful feedback on it.
> 
> Todo:
> - Add sensor calibration.
> - Re-organize code/files if deemed necessary by community.

Just fyi, I had a short discussion with Eric Miao about this. The 
conclusion was:

The patch itself is OK. It's just lacking some features, but these can 
be added later. The driver supports thermal reading only, but not 
accurate as the thermal calibration data is burned into the FUSE, and 
differ from chip to chip. At the moment only incorrect thermal 
information will be exposed to user space. The patch is lacking 
connections to cpufreq and cpu hotplug, but those could be added later, too.

Best regards

Dirk

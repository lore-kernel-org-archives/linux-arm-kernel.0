From: kernel@jic23.retrosnub.co.uk (Jonathan Cameron)
Date: Thu, 09 Sep 2010 13:43:20 +0100
Subject: Voltage/current/sensor monitoring interface and Wiegand
In-Reply-To: <20100909000245.GK14056@atomos.longlandclan.yi.org>
References: <20100909000245.GK14056@atomos.longlandclan.yi.org>
Message-ID: <4C88D668.7030501@jic23.retrosnub.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

....
> 
> How are voltage *monitors* normally written?  (note, not voltage
> *regulators*... this thing does not alter the voltage rails.)  I tried
> to make sense of lm-sensors, but that seems very ad-hoc (maybe I missed
> some document that explains it) to me.  It's hard to be clear on what is
> the *right* way to report a voltage or current reading to userspace.
typically hwmon, documentation is under /Documentation/hwmon/sysfs-interface.
> 
> For the temperature and light sensing... temperature sensors certainly
> exist in the PC world, and maybe I should look closely at how they are
> normally done, but I wasn't sure about the light sensor.  I was thinking
> maybe an input device with some new absolute value reported?
Light sensing options are currently either /misc or /staging/iio/light.

There are several different interfaces unfortunately.  IIO can work with
a bridge (via uinput) to generate input events is that is what you need.
The interface is still a bit unstable, though it is getting cleaned up
at the moment.
> 
> Likewise with the PIR sensor, I notice there's a "gesture" input
> (MSC_GESTURE)... seems appropriate?  Or am I barking up the wrong tree?
Does it look like a button (e.g. is it a straight on off device with
no control parameters etc)? Dmitry, what would you put this as and would
this be acceptable in input?  

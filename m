From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Apr 2016 08:29:16 -0700
Subject: 4.4: camera and unlock buttons produce tons of interrupts (was
 Re: N900 sleep mode)
In-Reply-To: <20160405142250.GA6429@amd>
References: <20160201181316.GM19432@atomide.com> <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com> <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com> <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com> <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com> <20160405142250.GA6429@amd>
Message-ID: <20160405152916.GE16484@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [160405 07:23]:
>
> Ok, I realized that _something_ set up my keyboard on console, too, so
> I'm able to do "init 1" and still interact with the console.
> 
> cm_idlest1_core blocking bits are now 0x42 pretty consistently. But
> they stay 0x42, even when screen is on (and screen on prevents low
> power, right?) so I guess they are not the whole story.

Yes they stay at 0x42. And it seems you've configured the UART
idle timeouts too.

> I'm able to get down to 50mA power consumption with screen off. I was
> getting 90mA with X, wifi in powersave and screen off.
> 
> Head proximity sensor is still on in this configuration. But I guess
> that should not keep the system busy...?
> 
> Ok, wait a moment, I'm getting "Camera Focus", "Camera Capture" and
> "Lock button" interrupts ... at something like 20/second. Without
> touching anything. Hmm. Also "pm_wkup", but that might be
> expected. Plus, 49052000.gpio and 49054000.gpio are rather
> active. Might be related to the above. Also "gp_timer" and
> 48070000.i2c are active, perhaps also related. I don't think I have
> the camera working...

Hmm that does not sound right at all for the GPIOs. The pm_wkup
interrupt triggers every time you hit wfi pretty much, so that
should be OK.

> "Lock button" interrupt stops increasing as long as I hold the lock
> button in the "unlock" position. "Camera Focus" and "Camera Capture"
> will stop increasing when I hold down the Camera button.

I have not seen that issue last time I checked. Sorry won't
be able to test it until Thursday, maybe there's some GPIO
regression now.

Regards,

Tony

From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 1 Feb 2015 12:38:13 +0100
Subject: bq2415x_charger.c: battery is discharged (fast, 224mA) when it
 should be charged
In-Reply-To: <201502011108.16071@pali>
References: <20150201094702.GA21628@amd>
 <201502011108.16071@pali>
Message-ID: <20150201113813.GA6570@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Sun 2015-02-01 11:08:16, Pali Roh?r wrote:
> On Sunday 01 February 2015 10:47:02 Pavel Machek wrote:
> > Hi!
> > 
> > I connected N900 with full battery using USB. For some reason,
> > charge limit was set to 100mA, battery was "full" and was
> > discharging:
> > 
> 
> Make sure you have loaded some usb gadget. Without it battery 
> charging via dedicated wallcharger (and probably also usb host 
> charger) does not working. g_nokia should be OK.

I had that loaded (was running from root over USB at the moment.)

> Try also compiling kernel with CONFIG_USB_GADGET_VBUS_DRAW=500
> 
> Also for charger autodetection you need to have loaded 
> isp1704_charer.ko module (or compiled into kernel).
> 
> And make sure that isp1704_charger is loaded before module 
> bq2415x_charger (there is some probe defer, no idea if it works 
> as excepted).

It seems bq2415x_charger is the problem: it all started working when I
did echo reset > mode... 

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

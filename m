From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 10 Jan 2015 19:41:46 +0100
Subject: [PATCH v2 3/8] watchdog: at91rm9200: use the regmap from mfd
In-Reply-To: <54B074B9.2090704@roeck-us.net>
References: <1420797094-9444-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1420797094-9444-4-git-send-email-alexandre.belloni@free-electrons.com>
 <54B074B9.2090704@roeck-us.net>
Message-ID: <20150110184146.GH2447@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2015 at 16:39:21 -0800, Guenter Roeck wrote :
> On 01/09/2015 01:51 AM, Alexandre Belloni wrote:
> >  /* ......................................................................... */
> >@@ -204,6 +201,7 @@ static struct miscdevice at91wdt_miscdev = {
> >  static int at91wdt_probe(struct platform_device *pdev)
> >  {
> >  	int res;
> >+	regmap_st = dev_get_drvdata(pdev->dev.parent);
> >
> 
> Is it guaranteed that parent is never NULL, and that the parent's
> drvdata is always set ?
> 

The only way to probe the driver left is to use platform_data. It is
done from the MFD driver. If you prefer, I can test for NULL here and
return.

> Also, it seems that regmap_st will be overwritten if the device
> is already open (see code below). That may not be a good idea.
> 

I'm not sure what you meani, pdev->dev.parent and at91wdt_miscdev.parent
are not the same thing. I didn't touch the code below but I believe
there is no reason to pass in the probe twice and return -EBUSY.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

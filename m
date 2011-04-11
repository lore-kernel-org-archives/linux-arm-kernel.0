From: greg@kroah.com (Greg KH)
Date: Mon, 11 Apr 2011 14:25:13 -0700
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <BANLkTim155YxMUVJ=pmVs-rNhkovGPG6OQ@mail.gmail.com>
References: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
	<20110411210631.GA28559@kroah.com>
	<BANLkTim155YxMUVJ=pmVs-rNhkovGPG6OQ@mail.gmail.com>
Message-ID: <20110411212513.GA17809@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 11:19:13PM +0200, Rafa? Mi?ecki wrote:
> 2011/4/11 Greg KH <greg@kroah.com>:
> > On Mon, Apr 11, 2011 at 11:25:14PM +0200, Rafa? Mi?ecki wrote:
> >> +static void axi_release_core_dev(struct device *dev)
> >> +{
> >> + ? ? /* Silent lack-of-release warning */
> >> +}
> >
> > Ok, WTF!!!!
> 
> Thank you for your kindly words. It's much more enjoyable to work on
> kernel that way. I definitely made that on purpose.

I can't tell if you are kidding or not.

Please read the documentation for how to do this properly.  I find it
really hard to believe that you wrote that comment instead of putting in
the 2 lines of code required for this function.

Especially as-it-is, your code does not work properly and leaks memory
badly.  Why would you do that on purpose?

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Tue, 22 Nov 2011 11:13:47 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
Message-ID: <20111122191347.GB4844@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 09:57:41AM -0800, Mike Turquette wrote:
> > Ah, comments like this warm my heart.
> >
> > Come on, no abusing the kobject code please, if have problems with how
> > the kernel core works, and it doesn't do things you want it to, then why
> > not change it to work properly for you, or at the least, ASK ME!!!
> 
> Ok, I'm asking you now.  There are two ways to solve this problem:
> 
> 1) have kobject core create the lists linking the objects but defer
> allocations and any interactions with sysfs until later in the boot
> sequence, OR
> 
> 2) my code can create a list of clks (the same way that clkdev does)
> and defer kobject/sysfs stuff until later, which walks the list made
> during early-boot
> 
> #1 is most closely aligned with the code I have here, #2 presents
> challenges that I haven't really though through.  I know that OMAP
> uses the clk framework VERY early in it's boot sequence, but as long
> as the per-clk data is properly initialized then it should be OK.
> 
> What do you think?

#3 - use debugfs and don't try to create a sysfs interface for the clock
structures :)

thanks,

greg k-h

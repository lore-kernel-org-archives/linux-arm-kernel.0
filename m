From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 3 Mar 2014 15:35:40 -0800
Subject: [PATCH 1/3] soc: Introduce drivers/soc place-holder for SOC
 specific drivers
In-Reply-To: <2DD4A0BB-509F-4F76-AA03-0CAFC9CEFE97@codeaurora.org>
References: <1393629520-12713-1-git-send-email-santosh.shilimkar@ti.com>
 <1393629520-12713-2-git-send-email-santosh.shilimkar@ti.com>
 <20140302171206.6adbea6f@alan.etchedpixels.co.uk>
 <20140302204822.GA16158@quad.lixom.net>
 <2DD4A0BB-509F-4F76-AA03-0CAFC9CEFE97@codeaurora.org>
Message-ID: <20140303233540.GB28934@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 10:13:57AM -0600, Kumar Gala wrote:
> 
> On Mar 2, 2014, at 2:48 PM, Olof Johansson <olof@lixom.net> wrote:
> 
> > On Sun, Mar 02, 2014 at 05:12:06PM +0000, One Thousand Gnomes wrote:
> >> On Fri, 28 Feb 2014 18:18:38 -0500
> >> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> >> 
> >>> Based on earlier thread "https://lkml.org/lkml/2013/10/7/662" and
> >>> further discussion at Kernel Summit'2013, it was agreed to create
> >>> 'driver/soc' for drivers which are quite SOC specific.
> >>> 
> >>> Lets take the discussion forward with this patch.
> >> 
> >> So what happens if you put something in say soc/banana and 3 months later
> >> the same IP block shows up in two other devices both of which have their
> >> own soc/ directory already ?
> > 
> > This isn't so much about IP blocks as about all the other glue logic and
> > management functions that vendors so far seem to implement in their own ways.
> > 
> > I don't remember the name we agreed on, I don't think it was drivers/soc --
> > partly because naming it that brings up the kinds of questions you have.
> > Paul took it upon himself to start sorting this out (and merge through us on
> > arm-soc), so he hopefully remembers better than me. :)
> 
> I think it was drivers/soc for the case that Paul was going to look at.  I?d expect we?d go with drivers/soc/<VENDOR> to reduce churn between newer SoC families from a company sharing something with an older one, etc.
> 
> > 
> >> What happens when the same blocks shows up on both a SoC and
> >> later externally ?
> >> 
> >> Where does a soc specifc gpio driver go ?
> > 
> > drivers/gpio, of course. This isn't changing that.
> > 
> >> It seems to me we've got a lot of confusion here because drivers/ is
> >> split by type, and we've also got arch/* machine specific drivers and
> >> we've got drivers/platform which is intended as far as I can see for
> >> everything you'd put in drivers/soc except for that which goes in arch/*
> >> anyway.
> >> 
> >> If QMSS is arm specific why isn't it in arch/arm, if it's not why isn't
> >> it in drivers/platform ?
> > 
> > drivers/platform are for specific vendor platforms. I.e. various laptop
> > vendors, a few server vendors, etc. Code for a whole silicon vendor's driver
> > does not belong there.
> >> 
> >> Just trying to understand the point of drivers/soc. 
> > 
> > Shortcutting most of the discussion by focusing on this question. ;)
> > 
> > We've been struggling to find a home for some of the code that we want to keep
> > in the kernel tree, and we sat down to talk with (among others) Greg at KS to
> > try to figure out how to move forward.
> 
> We talked about drivers/lib and drivers/soc back at KS.  Greg was
> going to start of drivers/lib and Paul was going to look at
> drivers/soc.

Yes, drivers/lib/ is still on my TODO list, unfortunatly way down it...
I'll get to it "soon" with some variation of "soon" :(

greg "my inbox is full" k-h

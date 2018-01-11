From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 11 Jan 2018 08:30:38 +0100
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
In-Reply-To: <e81095ff-d491-9977-25e6-7ba6d28d5e72@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180110101755.GA5822@kroah.com>
 <006c4a95-9299-bd17-6dec-52578e8461ae@linux.intel.com>
 <20180110191703.GA20248@kroah.com>
 <8997e43c-683e-418d-4e2b-1fe3fefe254e@linux.intel.com>
 <20180110202740.GA27703@kroah.com>
 <e81095ff-d491-9977-25e6-7ba6d28d5e72@linux.intel.com>
Message-ID: <20180111073038.GA3600@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 01:46:34PM -0800, Jae Hyun Yoo wrote:
> On 1/10/2018 12:27 PM, Greg KH wrote:
> > On Wed, Jan 10, 2018 at 11:30:05AM -0800, Jae Hyun Yoo wrote:
> > > On 1/10/2018 11:17 AM, Greg KH wrote:
> > > > On Wed, Jan 10, 2018 at 11:14:34AM -0800, Jae Hyun Yoo wrote:
> > > > > On 1/10/2018 2:17 AM, Greg KH wrote:
> > > > > > On Tue, Jan 09, 2018 at 02:31:20PM -0800, Jae Hyun Yoo wrote:
> > > > > > > From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> > > > > > > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > This patch set provides support for PECI of AST2400/2500 which can give us PECI
> > > > > > > functionalities such as temperature monitoring, platform manageability,
> > > > > > > processor diagnostics and failure analysis. Also provides generic peci.h and
> > > > > > > peci_ioctl.h headers to provide compatibility to peci drivers that can be
> > > > > > > implemented later e.g. Nuvoton's BMC SoC family.
> > > > > > 
> > > > > > What is the "dev-4.10" in the subject for?  4.10 is really old and
> > > > > > obsolete :(
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > > 
> > > > > 
> > > > > I made this patch set on top of the v4.10 which OpenBmc project is currently
> > > > > using. I'll rebase this patch set onto the current kernel.org mainline.
> > > > 
> > > > What is "OpenBmc", and why are they using an obsolete and insecure
> > > > kernel for their project?  That seems like a very foolish thing to do...
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > 
> > > OpenBmc is an open source project to create a highly extensible framework
> > > for BMC (Board Management Controller) software for data-center computer
> > > systems:
> > > https://github.com/openbmc
> > > 
> > > Its current mainline is v4.10 but it is being kept upgrading so it will be
> > > upgraded to the latest stable or long-term version soon.
> > 
> > Why hasn't it been updated in the year since 4.10 was released?  That's
> > a _very_ long time to be running on a totally insecure kernel, and no
> > new development should ever be done on old kernels, that's even crazier
> > (as we can't go back in time and accept patches for new features to old
> > releases...)
> > 
> 
> Thanks for your pointing it out and I totally agree with you. Actually, we
> are preparing 4.13 update for now and an another update will be followed up.
> As I answered above, I'll rebase this patch set onto the latest kernel.org
> mainline. Sorry for my misunderstanding of upstream process.

4.13?  Why that kernel?  It too is obsolete and insecure and
unsupported.

What keeps you all from just always tracking the latest tree from Linus?
What is in your tree that is not upstream that requires you to have a
kernel tree at all?

And if you do have out-of-tree code, why not use a process that makes it
trivial to update the base kernel version so that you can keep up to
date very easily?  (hint, just using 'git' is not a good way to do
this...)

thanks,

greg k-h

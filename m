From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 26 Jun 2013 04:57:01 +0000
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83ECC9548@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, June 25, 2013 11:51 PM
> To: Balbi, Felipe
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Rini, Tom; Hiremath, Vaibhav; khilman at ti.com
> Subject: Re: OMAP baseline test results for v3.10-rc6
> 
> + Vaibhav and Kevin
> 
> Hi,
> 
> On Tue, 25 Jun 2013, Felipe Balbi wrote:
> 
> > On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
> > > Boot to userspace:
> > >     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt
> >
> > Paul, we have at least 2 different folks who can't reproduce your
> bone
> > and bone black boot to userspace failures. I wonder how you're trying
> to
> > boot them.
> >
> > Care to share your test scripts ?
> 
> Sure... the methodology is completely open and has been posted in the
> online logs since the first test cycle.  (For some reason, almost no
> one
> clicks through the test directory trees that I post online.  Is this a
> documentation issue?  What can we do to make it easier for people to
> explore this?)
> 


That?s not quite true, I remember going through your log in detail multiple
Times.

The issue is, for appended DTB you must enable 2 config options,

CONFIG_ARM_APPENDED_DTB = y
CONFIG_ARM_ATAG_DTB_COMPAT = y

OR

If you don?t want to change/modify default config (omap2plus_defconfig), 
Use separate DTB and zImage, which is standard way of booting kernel.

Same applies to BeagleBone Black. Infact same DTB and zImage boots up fine
On both boards without any issues.

Thanks,
Vaibhav

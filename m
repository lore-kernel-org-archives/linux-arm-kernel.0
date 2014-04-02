From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Apr 2014 11:01:02 +0300
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <533ABCEC.8040701@codethink.co.uk>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <20140331200620.GA13881@kroah.com>
 <533ABCEC.8040701@codethink.co.uk>
Message-ID: <20140402080102.GK2931@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 03:19:40PM +0200, Ben Dooks wrote:
> On 31/03/14 21:06, Greg KH wrote:
> > On Mon, Mar 31, 2014 at 06:41:56PM +0200, Sylwester Nawrocki wrote:
> >> This function adds a helper function to configure clock parents and rates
> >> as specified in clock-parents, clock-rates DT properties for a consumer
> >> device and a call to it before driver is bound to a device.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> [snip]
> 
> >
> > I don't understand why you need the driver core to initialize this one
> > type of thing?  That should be in a driver, or in a class, or at worse
> > case, the platform code.
> >
> > What makes clocks so "unique" here?
> 
> I suppose the issue here is that a lot of drivers currently use
> clocks and a number of systems have badly setup default clock trees
> at start time.
> 
> Mark Brown and others have argued that the management of clocks which
> is common to all devices should not live in the driver.

Exactly, this data should be part of the clock provider DT nodes, not
of the device nodes. 

Cheers,

Peter.

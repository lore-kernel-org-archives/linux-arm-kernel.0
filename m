From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 3 Dec 2013 22:39:38 +0100
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <20131203212914.GC31496@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com> <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org> <20131125094044.GE3176@lukather>
 <5299D3BA.8080700@kernel.org>
 <20131130140402.21abae28@endymion.delvare>
 <20131203212914.GC31496@lukather>
Message-ID: <20131203223938.7190a01c@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Dec 2013 22:29:14 +0100, Maxime Ripard wrote:
> Hi Jean,
> 
> On Sat, Nov 30, 2013 at 02:04:02PM +0100, Jean Delvare wrote:
> > > i2c has a generic binding that matches to the name bit of the
> > > i2c_device_id array.  That is then exported in sysfs.  There are
> > > quite a lot of instances of underscores out there in these names.
> > > Thus unforutnately they can't be changed without possibly breaking
> > > userspace.  Typically those same names are also output by IIO
> > > though obviously we could keep that the same whilst changing the
> > > dt binding.
> > > 
> > > Also the i2c binding allows binding after dropping the vendor
> > > prefix which is even more 'interesting'. See of_modialias_node in
> > > drivers/of/base.c
> > > 
> > > I'd therefore argue in favour of just leaving the underscores in
> > > existing drivers as a nasty bit of legacy and doing our best to
> > > not introduce any new ones!
> > 
> > I don't know what is the problem with underscores, but please note
> > that hwmon i2c devices are NOT allowed to have dashes in their name
> > because that would break libsensors.
> 
> As far as I remember, hwmon doesn't handle the accelerometers or
> gyroscopes, does it?

You remember correctly, it does not and never will.

-- 
Jean Delvare

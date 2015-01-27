From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Jan 2015 20:40:53 +0100
Subject: [linux-sunxi] Re: [PATCH] arm: sunxi: input: RFC: Add sysfs
 voltage for sun4i-lradc driver
In-Reply-To: <1422352189.23189.12.camel@plaes.org>
References: <1422291516-24895-1-git-send-email-plaes@plaes.org>
 <20150127091829.GD7200@lukather>
 <1422352189.23189.12.camel@plaes.org>
Message-ID: <20150127194053.GN7200@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:49:49AM +0200, Priit Laes wrote:
> 
> On Tue, 2015-01-27 at 10:18 +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > On Mon, Jan 26, 2015 at 06:58:32PM +0200, Priit Laes wrote:
> > > ---
> > 
> > Like Hans was pointing out, commit log and signed-off-by please
> > 
> > >  .../ABI/testing/sysfs-driver-input-sun4i-lradc     |  4 ++
> > >  drivers/input/keyboard/sun4i-lradc-keys.c          | 49 
> > > +++++++++++++++++-----
> > >  2 files changed, 43 insertions(+), 10 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-
> > > sun4i-lradc
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-input-sun4i-
> > > lradc b/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> > > new file mode 100644
> > > index 0000000..e4e6448
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> > > @@ -0,0 +1,4 @@
> > > +What:          /sys/class/input/input(x)/device/voltage
> > > +Date:          February 2015
> > > +Contact:       Priit Laes <plaes@plaes.org>
> > > +Description:   ADC output voltage in microvolts or 0 if device is 
> > > not opened.
> > 
> > Why is it returning 0 when "device is not opened" ? What does that 
> > even mean? You can't read that file without opening it.
> 
> It means that something has to open the /dev/input/inputX device which 
> sets up the ADC before the voltage can be read from the sysfs file.

It's a bug.

> > As I told you already, if you're going to expose this an ADC in the 
> > end, the proper solution is to use the IIO framework, not adding a 
> > custom sysfs file.
> 
> My intention was to expose just a simple debug output, so one can 
> press the buttons and read the voltages for devicetree keymap.
> 
> If anyone can suggest a simpler approach than current sysfs based one, 
> I would do it. But full blown iio driver is currently out of scope.

For this kind of ADCs, it's really not that hard, and provide more or
less the same interface.

> Also, Carlo's (ccaione) initially submitted (?) driver for lradc 
> utilized iio subsystem.

And it was dropped because
no-one-would-use-this-to-retrieve-the-voltage-ever :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/c3dc213a/attachment-0001.sig>

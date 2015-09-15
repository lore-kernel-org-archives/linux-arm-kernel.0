From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 15 Sep 2015 13:22:18 -0700
Subject: [PATCH v2 2/3] platform/chrome: Support reading/writing the
 vboot context
In-Reply-To: <CABxcv=mnCNQPtVBU4tPOWD237_-RojoW+RVLTj+F=3PHbUHfQQ@mail.gmail.com>
References: <1442234049-18637-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442234049-18637-3-git-send-email-emilio.lopez@collabora.co.uk>
 <CABxcv=m23sfK=jOCswirQRB1SbP70VnomKp6hhwFhRLHiabq4w@mail.gmail.com>
 <55F86E74.9010907@collabora.co.uk>
 <CABxcv=mnCNQPtVBU4tPOWD237_-RojoW+RVLTj+F=3PHbUHfQQ@mail.gmail.com>
Message-ID: <20150915202218.GA25914@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 09:43:35PM +0200, Javier Martinez Canillas wrote:
> Hello Emilio,
> 
> On Tue, Sep 15, 2015 at 9:16 PM, Emilio L?pez
> <emilio.lopez@collabora.co.uk> wrote:
> 
> [snip]
> 
> >>>
> >>>   obj-$(CONFIG_CHROMEOS_LAPTOP)  += chromeos_laptop.o
> >>>   obj-$(CONFIG_CHROMEOS_PSTORE)  += chromeos_pstore.o
> >>> -cros_ec_devs-objs               := cros_ec_dev.o cros_ec_sysfs.o
> >>> cros_ec_lightbar.o
> >>> +cros_ec_devs-objs               := cros_ec_dev.o
> >>> +cros_ec_devs-objs               += cros_ec_lightbar.o
> >>> +cros_ec_devs-objs               += cros_ec_sysfs.o
> >>> +cros_ec_devs-objs               += cros_ec_vbc.o
> >>
> >>
> >> Why are you changing the Makefile? AFAIK += is usually used when the
> >> compilation is conditional based on a Kconfig symbol but since these
> >> are build unconditionally, I'll just keep it as foo := bar baz
> >
> >
> > As far as I'm aware, += is append[0]. It's used for stuff like
> > obj-$(CONFIG_CHROMEOS_LAPTOP)  += chromeos_laptop.o
> > because the left part will resolve to "obj-y" or similar, and you want to
> > add to it, not replace it. I only changed the Makefile here because the line
> > was growing too long, and I thought it looked neater this way; it shouldn't
> > cause any functional change apart from the intended one.
> >
> > [0] https://www.gnu.org/software/make/manual/html_node/Appending.html
> >
> 
> Yes, I know how Kbuild works. What I tried to say is that you usually
> append based on a Kconfig symbol. In fact even you are mentioning such
> an example.
> So appending unconditionally like you are doing makes the Makefile
> harder to read IMHO. If the line grows to long you can use a backlash
> (\) char to split the line.

Either format is just fine, don't get too picky here please.

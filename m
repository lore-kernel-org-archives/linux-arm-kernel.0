From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 14 Aug 2015 17:16:32 -0700
Subject: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c explicitly
 non-modular
In-Reply-To: <20150811060544.GJ9751@windriver.com>
References: <1439081497-14986-1-git-send-email-paul.gortmaker@windriver.com>
 <1439081497-14986-6-git-send-email-paul.gortmaker@windriver.com>
 <CAGhQ9Vxjymt4z32s3x2B8b6ypgn3Bzh1ncbqxqidfPyM2k87jw@mail.gmail.com>
 <20150811060544.GJ9751@windriver.com>
Message-ID: <20150815001632.GA20581@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 02:05:44AM -0400, Paul Gortmaker wrote:
> [Re: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c explicitly non-modular] On 10/08/2015 (Mon 20:42) Joachim Eastwood wrote:
> 
> > Hi Paul,
> > 
> > On 9 August 2015 at 02:51, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > > The Kconfig currently controlling compilation of this code is:
> > >
> > > 8250/Kconfig:config SERIAL_8250_LPC18XX
> > > 8250/Kconfig:        bool "NXP LPC18xx/43xx serial port support"
> > >
> > > ...meaning that it currently is not being built as a module by anyone.
> > >
> > > Lets remove the modular code that is essentially orphaned, so that
> > > when reading the driver there is no doubt it is builtin-only.
> > 
> > The bool in KConfig is more or less a copy-paste mistake on my side. I
> > really meant for this driver to be buildable as module and it builds
> > just fine with 'm'.
> > 
> > Want me send a patch changing it to tristate or will you handle it?
> 
> I will do a v2 in the next day or so with collected ACKs and this patch
> replaced, unless Greg jumps in and indicates he'd like something
> different.

Nope, that would be fine with me, thanks.

greg k-h

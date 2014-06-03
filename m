From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 3 Jun 2014 14:14:20 -0700
Subject: [PATCH] tty: serial: msm: Fix section mismatch warning
In-Reply-To: <CAOesGMh5knixNp+dgWnQu5M00N4ZMm10PoBh3YVTquryfRh-cw@mail.gmail.com>
References: <1401826402-1079-1-git-send-email-galak@codeaurora.org>
 <20140603203318.GB6582@kroah.com>
 <CAOesGMh5knixNp+dgWnQu5M00N4ZMm10PoBh3YVTquryfRh-cw@mail.gmail.com>
Message-ID: <20140603211420.GA1192@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 02:04:43PM -0700, Olof Johansson wrote:
> On Tue, Jun 3, 2014 at 1:33 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jun 03, 2014 at 03:13:22PM -0500, Kumar Gala wrote:
> >> WARNING: drivers/tty/built-in.o(.data+0x3544): Section mismatch in
> >> reference from the variable msm_platform_driver to the function
> >> .init.text:msm_serial_probe()
> >> The variable msm_platform_driver references
> >> the function __init msm_serial_probe()
> >> If the reference is valid then annotate the
> >> variable with __init* or __refdata (see linux/init.h) or name the variable:
> >> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> >
> > Where is this mismatch showing up at?  3.15-rc8, 3.16-rc1?  Somewhere
> > older or else?
> 
> Linus' next branch, it was merged through arm-soc. I didn't notice it
> in time to fix it before we sent to Linus. :(

Ok, do you want to take this patch then?  I don't mind taking it through
my tree, but it will have to wait until after 3.16-rc1 is out.  It's up
to you.

thanks,

greg k-h

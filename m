From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 18 Apr 2015 09:20:58 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <2102140.2VHBUJBHNB@wuerfel>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <2102140.2VHBUJBHNB@wuerfel>
Message-ID: <1429341658.16771.123.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-04-17 at 22:07 +0200, Arnd Bergmann wrote:
> On Friday 17 April 2015 09:50:56 Jens Wiklander wrote:
> > +static const struct file_operations tee_fops = {
> > +	.owner = THIS_MODULE,
> > +	.open = tee_open,
> > +	.release = tee_release,
> > +	.unlocked_ioctl = tee_ioctl
> > +};
> 
> Add a .compat_ioctl function, to make it work on arm64 as well.
> If you got all the data structures right, you can use the same
> tee_ioctl function.
> 
> Minor nit: put a comma behind the last line in each struct initialization
> to make it easier to add another callback.

And another nit: this is built-in only code, right? So, according to
include/linux/export.h, THIS_MODULE will be basically equivalent to
NULL. So I think you can drop that line.

Thanks,


Paul Bolle

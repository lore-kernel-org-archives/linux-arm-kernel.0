From: B10812@freescale.com (Aggrwal Poonam-B10812)
Date: Mon, 30 Jul 2012 09:13:02 +0000
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <20120727181208.GC23105@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727181208.GC23105@kroah.com>
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079C0BEC@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=freescale.com at lists.ozlabs.org] On Behalf Of Greg
> KH
> Sent: Friday, July 27, 2012 11:42 PM
> To: Singh Sandeep-B37400
> Cc: devel at driverdev.osuosl.org; linuxppc-dev at lists.ozlabs.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [2/3][PATCH][v2] TDM Framework
> 
> On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep at freescale.com wrote:
> > +static struct kobj_type tdm_type = {
> > +	.sysfs_ops = &tdm_ops,
> > +	.default_attrs = tdm_attr,
> > +};
> 
> Ah, also, as per the documentation in the kernel (go look, it's there), I
> now get to publicly mock you for ignoring the error messages that the
> kernel is giving you when you try to shut down your code path.
> 
> Well, to be fair, you are leaking memory like a sieve, so I doubt you
> ever saw those error messages because you never cleaned up after
> yourself, so perhaps I can forgive you, but your users can't, sorry.
> They like to rely on the fact that Linux is a reliable operating system,
> don't cause them to doubt that.
> 
> Please fix this code, it's horribly broken.  Read
> Documentation/kobject.txt for why.  That file was written for a reason,
> and not just because we like writing documentation (hint, we hate to...)
To be honest we are not sysfs experts. Thanks for pointing to the documentation.
We will rework the stuff.

Regards
Poonam
> 
> Ugh,
> 
> greg k-h
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 10 Sep 2015 15:13:46 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
Message-ID: <20150910141346.GV10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 02:52:25PM +0100, Stefano Stabellini wrote:
> > > In any case this should be separate from the shim ABI discussion.
> > 
> > I disagree; I think this is very much relevant to the ABI discussion.
> > That's not to say that I insist on a particular approach, but I think
> > that they need to be considered together.
> 
> Let's suppose Xen didn't expose any RuntimeServices at all, would that
> make it easier to discuss about the EFI stub parameters?

Possibly :)

> In the grant
> scheme of things, they are not that important, as Ian wrote what is
> important is how to pass the RSDP.

So, we have discussed in the past having the ability to get at
configuration tables when UEFI is not available. Say, for example,
that we wanted SMBIOS support on a platform with U-Boot firmware.

Since all that is needed then is a UEFI System Table with a pointer to
a configuration table array, this should be fairly straightforward to
implement statically. The other parameters would not be necessary.

It would however require minor changes to the arm64 kernel UEFI support.

/
    Leif

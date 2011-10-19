From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 19 Oct 2011 13:27:20 +1030
Subject: [PATCH v3] virtio: Add platform bus driver for memory mapped
	virtio device
In-Reply-To: <1318931075.3146.285.camel@hornet.cambridge.arm.com>
References: <1317841030-17758-1-git-send-email-pawel.moll@arm.com>
	<1317919843-8343-1-git-send-email-pawel.moll@arm.com>
	<1317921230.28696.102.camel@hornet.cambridge.arm.com>
	<87lisjq6tu.fsf@rustcorp.com.au>
	<1318931075.3146.285.camel@hornet.cambridge.arm.com>
Message-ID: <87ty75adtb.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2011 10:44:35 +0100, Pawel Moll <pawel.moll@arm.com> wrote:
> > or actually specify it as
> > the power of 2 to use, (ie. valid values are 1 through 16, with 12 being
> > the value that virtio PCI would use).
> > 
> > Otherwise you have to do a divide on the qemu side.
> 
> Oh, really? My host-side implementation is just doing that:
> 
>         addr += align - 1;
>         addr &= ~(align - 1);

OK, so you're assuming power of 2.  Make sure you kill the guest or at
least the device if it's not though.

> \item The dynamic configuration changes, as described in p. 2.4.3
> ``Dealing With Configuration Changes'' are not permitted.

This means some devices simply won't work, at least in theory.  Why
don't you support this?

Thanks!
Rusty.

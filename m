From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 11:13:53 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140320171930.GA28238@arm.com>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320171930.GA28238@arm.com>
Message-ID: <20140321111353.GA24945@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 05:19:32PM +0000, Catalin Marinas wrote:
> On Thu, Mar 20, 2014 at 01:43:57PM +0000, Mark Brown wrote:

> > Given ACPI (which really looks like it's going to happen at some point
> > and presumably make OF optional) I'm not sure removing the handling of
> > OF is actually constructive but whatever, it's done now...

> CONFIG_OF will always be enabled in the kernel even when we get ACPI. We
> still use the chosen DT node to tell the kernel about ACPI.

One thing that occurs to me with this - if we've always got a DT even if
we are booting with ACPI that might confuse code that implements
handling for firmware idioms.  The regulator code does this sort of
thing, though in that case we make exactly the same assumptions for ACPI
and DT so there won't be any confusion.  There's a few other examples
though and we might acquire more by the time ACPI gets merged.  Probably
not a big deal but something that needs attention paying.

I was aware that there was a stub DT on ACPI systems but had expected
that if we were booting with real ACPI support that'd get masked from
the running system.  I can see why at least initially we'd want to just
pull in the infrastructure to use when identifying that this is an ACPI
system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/1dc5d223/attachment.sig>

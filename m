From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Nov 2013 09:51:08 -0500
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <52814AFB.3070600@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
Message-ID: <20131112145108.GQ10335@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 02:24:11PM -0700, Stephen Warren wrote:
> On 11/11/2013 01:29 PM, Jason Cooper wrote:
> > Consumers of the Linux kernel's build products are beginning to hardcode
> > the filenames of the dtbs generated.  Since the dtb filenames are
> > currently the dts filename s/dts/dtb/, this prevents the kernel
> > community from renaming dts files as needed.
> 
> My take is that the DTB filenames are part of the ABI, and therefore the
> DTS filenames are also part of the ABI. Why would we want to rename them?

This idea originated from a conversation with Olof about starting to
pre-pend the manufacturer name to the dts files:

  https://lkml.org/lkml/2013/11/8/378

imho, at some point there is going to be an ABI breakage wrt dtb names
when the devicetree moves to a separate repository.  All users will have
to rework their scripts at that point.

If that assumption is correct, why not put in place a _good_ ABI that
allows us to be flexible as needed and specific for end users?  If you're
still with me on this idea, shouldn't we put this in place now (as
symlinks, thus retaining old names) so that we can switch over more
easily later?

thx,

Jason.

From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 5 Aug 2011 23:58:45 +0100
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
Message-ID: <20110805225845.GC6404@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 06:07:15PM -0500, Matt Sealey wrote:
> Hi Grant, Shawn,
> 
> 
> 
> On Mon, Jul 25, 2011 at 3:46 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > This could get really verbose in a really big hurry. ?Fortunately the
> > dtb format is sophisticated enough to only store each unique property
> > name once, so the data shouldn't be huge, but it is still going to
> > make for huge source files. ?Can you think of a more concise
> > representation?
> 
> Yes: no representation at all. The correct place for IOMUX setup being
> done is *inside the boot firmware as soon as physically possible* and
> not seconds into boot after U-Boot has made a console, done a boot
> timeout, loaded scripts, kernels and ramdisks from media and then
> uncompressed and entered a Linux kernel.

We've had this argument before.  There are many use cases where the
firmware simply cannot be relied upon to do the right thing.

g.

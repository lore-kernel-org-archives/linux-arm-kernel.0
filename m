From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 12:04:04 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <20140725092108.GB24268@arm.com>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
 <20140724191237.GM17528@sirena.org.uk>
 <20140725092108.GB24268@arm.com>
Message-ID: <20140725110404.GQ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 10:21:09AM +0100, Catalin Marinas wrote:
> On Thu, Jul 24, 2014 at 08:12:37PM +0100, Mark Brown wrote:

> > This is still broken -next.

> It should now be temporarily fixed for the defconfig
> (CONFIG_AUTIDSYSCALL disabled). I'm reluctant to merge the audit tree in
> the arm64 tree as (a) I haven't seen a confirmation that this branch is
> stable and will go upstream as is and (b) there are x86 changes without
> Acks from the x86 maintainers (whether needed or not, I can't say).

I'd not expect it to be essential, it's just a function prototype
change.

> So my temporary patch is some #ifndef's around the offending code. It
> will be reverted and your patch applied once the audit tree meets the
> arm64 tree.

That's good thanks, though it's still going to mean we have massive
bisection breaks and anyone with an existing config will run into
trouble - I'm going to be adding all*config builds to my daily tests
soon too which will still trigger the issue).  

I suspect the easiest thing would be to cherry pick the commit over (it
can always be reverted later on if there's an issue) if a shared branch
can't be arranged.  It's a real shame Eric hasn't replied here...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/7967cc6d/attachment.sig>

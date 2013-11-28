From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 11:41:47 +0900
Subject: [PATCH RFC v2 15/17] ARM: shmobile: Remove non-multiplatform
 Marzen reference support
In-Reply-To: <CANqRtoSNDC7+qnu5Nf-UTHXNDf680o8Ex9_XQJWAUqVfjKbi0g@mail.gmail.com>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
 <1385451139-29686-16-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoSNDC7+qnu5Nf-UTHXNDf680o8Ex9_XQJWAUqVfjKbi0g@mail.gmail.com>
Message-ID: <20131128024146.GF22413@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 05:51:16PM +0900, Magnus Damm wrote:
> On Tue, Nov 26, 2013 at 4:32 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Now that r8a7779 has CCF support remove the legacy Marzen reference
> > Kconfig bits CONFIG_MACH_MARZEN_REFERENCE for the non-multiplatform
> > case.
> >
> > Starting from this commit Marzen board support is always enabled via
> > CONFIG_MACH_MARZEN, and CONFIG_ARCH_MULTIPLATFORM is used to select
> > between board-marzen.c and board-marzen-reference.c
> >
> > The file board-marzen-reference.c can no longer be used together with
> > the legacy sh-clk clock framework, instead CCF is used.
> >
> > Based on work for the Koelsch board by Laurent Pinchart.
> >
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> > v2
> > * Correct changelog to refer to marzen instead of koelsch
> > * Do not add typo to Makefile
> 
> I think we need to discuss _when_ to do this in more detail. I know
> this follows the same style as Laurent's patches, but I don't think
> we're ready to flip the switch yet. I propose that we let DT reference
> coexist with multiplatform and non-multiplatform cases for a while to
> make testing easier and give time to migrate.

Yes, I agree this needs to be discussed.

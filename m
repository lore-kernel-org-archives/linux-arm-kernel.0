From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Jul 2013 16:04:49 +0100
Subject: [PATCH] drm/exynos: Add missing includes
In-Reply-To: <008a01ce771e$afe02670$0fa07350$%dae@samsung.com>
References: <1372683355-27460-1-git-send-email-broonie@kernel.org>
 <008a01ce771e$afe02670$0fa07350$%dae@samsung.com>
Message-ID: <20130702150449.GO27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 09:21:32PM +0900, Inki Dae wrote:

> > Ensure that all externally accessed functions are correctly prototyped
> > when defined in each file by making sure the headers with the protoypes
> > are included in the file with the definition.

> I don't see why this patch is needed. it seems like including unnecessary
> headers so it makes the code size enlarged.

Well, aside from it being basic good practice and allowing the compiler
to check for errors in the prototypes this is also something that sparse
warns about.

If the resulting binary size is changed by having the headers included
then that indicates a bug in the headers - they *really* shouldn't be
doing anything substantial here.  None of the headers in question looked
at all worrying.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/d4c8cc03/attachment.sig>

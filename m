From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 26 Aug 2015 18:30:00 +0100
Subject: [PATCH 2/3] arm64: use core efi=debug instead of uefi_debug
 command line parameter
In-Reply-To: <20150826172455.GB2837@codeblueprint.co.uk>
References: <1440595498-30630-1-git-send-email-leif.lindholm@linaro.org>
 <1440595498-30630-3-git-send-email-leif.lindholm@linaro.org>
 <20150826172455.GB2837@codeblueprint.co.uk>
Message-ID: <20150826173000.GG10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 06:24:55PM +0100, Matt Fleming wrote:
> On Wed, 26 Aug, at 02:24:57PM, Leif Lindholm wrote:
> > Now that we have an efi=debug command line option in the core code, use
> > this instead of the arm64-specific uefi_debug option.
> > 
> > Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> > ---
> >  Documentation/arm/uefi.txt |  2 --
> >  arch/arm64/kernel/efi.c    | 19 +++++--------------
> >  2 files changed, 5 insertions(+), 16 deletions(-)
> 
> Are there no concerns with backwards-compatibility here? I expected
> this patch to internally convert uefi_debug to efi=debug if old boot
> loaders, kernel config, etc specify it.
> 
> Is that something that can be safely ignored?

Since it is purely a debug feature, I opted to just drop it.
I don't have strong feelings, and it could certainly be kept as an
arm64-only alias (but setting the EFI_DBG flag) if others disagree.

/
    Leif

From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 29 Oct 2015 15:21:42 +0000
Subject: [PATCH] arm64/efi: do not assume DRAM base is aligned to 2 MB
In-Reply-To: <5632347E.2070303@codeaurora.org>
References: <1446127645-4115-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151029145754.GD3440@arm.com> <5632347E.2070303@codeaurora.org>
Message-ID: <20151029152141.GH28221@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 10:00:14AM -0500, Timur Tabi wrote:
> On 10/29/2015 09:57 AM, Will Deacon wrote:
> >So is this fixing a regression introduced in 4.3? If so, can I have a
> >Fixes: tag too, please? (I was under the impression that this was a
> >longstanding issue, but the thread hasn't been easy to follow).
> 
> It fixes a bug introduced by:
> 
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>  2015-07-24 06:38:27
> Committer: Will Deacon <will.deacon@arm.com>  2015-07-27 05:08:41
> Parent: ddeeefe2dfbe1fa6b116b9362b1bec465b64c873 (arm64/efi:
> efistub: Apply __init annotation)
> Child:  739fa11938bec53a849b77b2042237a0e17c70ae (arm64/efi: do not
> assume DRAM base is aligned to 2 MB)
> Branches: dcc, master, qserver, qserver2, remotes/origin/master, tty
> Follows: v4.2-rc4
> Precedes: v4.3-rc1
> 
>     arm64: efi: prefer AllocatePages() over efi_low_alloc() for vmlinux

As it wasn't in the context, that's commit ID e38457c361b30c5a, which
was introduced in v4.3-rc1.

However, the check on the base address was always buggy since its
introduction in v3.16 in commit 3c7f255039a2ad6e ("arm64: efi: add EFI
stub"), so that portion needs to be backported further.

Thanks,
Mark.

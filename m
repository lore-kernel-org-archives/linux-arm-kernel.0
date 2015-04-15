From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 15 Apr 2015 10:55:06 +0100
Subject: [PATCH] efi: stub: use a pool allocation for the cmdline
In-Reply-To: <CAKv+Gu-KHpSWLKOgA7UW8C6L1-K3dOieNmF2=qq_t5N73u3Spg@mail.gmail.com>
References: <1428670569-23089-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAFECyb9efREE=BU5RGSbzAGHqi5CkivUuTf=BRdq02GvFqJaOA@mail.gmail.com>
 <CAKv+Gu-KHpSWLKOgA7UW8C6L1-K3dOieNmF2=qq_t5N73u3Spg@mail.gmail.com>
Message-ID: <20150415095506.GA4804@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Apr, at 07:14:34PM, Ard Biesheuvel wrote:
> 
> It is not such a big deal: the memory is reclaimed anyway, I was just
> trying to reduce the fragmentation a bit, and trying to avoid
> efi_xxx_alloc() which are substantially heavier than calling
> allocate_pool() or allocate_pages() directly.

Out of curiosity, do you have any runtime numbers to backup the claim
that allocate_*() is substantially more lightweight?

-- 
Matt Fleming, Intel Open Source Technology Center

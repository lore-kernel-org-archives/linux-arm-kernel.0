From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 28 Jul 2015 23:06:40 +0100
Subject: [PATCH v2] arm64/efi: prefer AllocatePages() over
 efi_low_alloc() for vmlinux
In-Reply-To: <CAKv+Gu_EtOV8wannMLG87ai_x3ARu4rUSo9D6w2DQ+Kb5Kjn-A@mail.gmail.com>
References: <1437737907-10477-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150728211752.GE2773@codeblueprint.co.uk>
 <CAKv+Gu_EtOV8wannMLG87ai_x3ARu4rUSo9D6w2DQ+Kb5Kjn-A@mail.gmail.com>
Message-ID: <20150728220640.GF2773@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jul, at 11:24:23PM, Ard Biesheuvel wrote:
> 
> This workaround fixes another issue as well: the arm64 kernel needs to
> be loaded 512 KB above a 2MB aligned boundary, and using
> efi_low_alloc() as we do loses (2 MB - 512 KB) at the bottom if part
> of that 512 KB is occupied, since efi_low_alloc() is not aware of the
> fact that the first 512 KB will remain unused.
> 
> What would be most helpful is if efi_low_alloc() could take an offset
> param in addition to the alignment, i.e., alignment == 2MB and offset
> == 512 KB. The offset would default to 0, reverting to the original
> behavior.
> 
> If you'd be ok with such a change, I can propose it instead, and wire
> it up into this function.

It's probably because it's late but I'm having trouble thinking this
change through fully.

If it's not too much work, sure, please go ahead and propose a patch,
even the untested, uncompiled "this is what I'm thinking" type.

-- 
Matt Fleming, Intel Open Source Technology Center

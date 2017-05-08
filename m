From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 May 2017 22:22:14 +0200
Subject: [PATCH V15 11/11] arm/arm64: KVM: add guest SEA support
In-Reply-To: <dade63eb-b231-d7a5-f307-9737d7b088f2@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-12-git-send-email-tbaicar@codeaurora.org>
 <20170508174058.5hbujeblxq5z6iwa@pd.tnic>
 <dade63eb-b231-d7a5-f307-9737d7b088f2@codeaurora.org>
Message-ID: <20170508202214.gmfy27d6ypv6af4n@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 01:54:44PM -0600, Baicar, Tyler wrote:
> This was discussed in the v12 and v13 patch series. There is existing
> code in kvm_handle_guest_abort for injecting an abort back into the
> guest. We only want to do that if it was an abort that was not handled
> by the firmware first handling. So here we verify that at least one of
> the SEA error sources successfully reported an error record sent from
> the firmware. If there were no errors reported by firmware, then we
> want to continue with the current implementation that will inject the
> virtual abort. (kvm_inject_vabt)

So this needs to be in a comment there. This is generic code in the
sense that it is in drivers/acpi/ and it should say why it is doing that
special thing. I know, SEA is ARM-only, as far as I'm gathering from
reviewing this, but this behavior needs to be documented as it is not
obvious.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

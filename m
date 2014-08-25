From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 25 Aug 2014 11:23:53 -0700
Subject: [PATCHv3 1/7] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <CAGXu5jLur_gdXs2X5BCmxB6L5HwgyP12jkrufK7bpS0Cxhp_+Q@mail.gmail.com>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>	<1408584039-12735-2-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jLur_gdXs2X5BCmxB6L5HwgyP12jkrufK7bpS0Cxhp_+Q@mail.gmail.com>
Message-ID: <53FB7F39.8050406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2014 10:41 PM, Kees Cook wrote:
>
>
>
> On Wed, Aug 20, 2014 at 6:20 PM, Laura Abbott <lauraa@codeaurora.org
> <mailto:lauraa@codeaurora.org>> wrote:
>
>     handle_arch_irq isn't actually text, it's just a function pointer.
>     It doesn't need to be stored in the text section and doing so
>     causes problesm if we ever want to make the kernel text read only.
>     Declare handle_arch_irq as a proper function pointer stored in
>     the data section.
>
>     Signed-off-by: Laura Abbott <lauraa@codeaurora.org
>     <mailto:lauraa@codeaurora.org>>
>
>
> Out of curiosity, did you find these cases via inspection, or were you
> debugging faults after making stuff RO/NX?
>


These were all faults after making things RO/NX. It was a good way to know
that the code was working as expected.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

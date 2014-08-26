From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Aug 2014 18:08:45 -0700
Subject: [PATCHv3 3/7] arm64: Move cpu_resume into the text section
In-Reply-To: <53FBD834.30507@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-4-git-send-email-lauraa@codeaurora.org>
 <53FB9DCB.3080602@codeaurora.org> <53FBD834.30507@codeaurora.org>
Message-ID: <53FBDE1D.7070001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/14 17:43, Laura Abbott wrote:

> Good point. I think this was a patch I added when I was debugging other
> issues and assumed it would be needed (code in .data segment, seems
> naturally a problem, right?) . When I revert the patch though it seems
> to work just fine. I suspect the comment about pc relative load is no
> longer relevant since I use the relocation trick to properly access
> sleep_save_sp in the data section.

Ah good. Can we move this code to the text section on arm32 as well
please? Probably update the commit text too.

>
> Since it's not technically needed, I could drop the patch and add one
> adding the comment back saying this was done on purpose. On the other
> hand, I wonder if I could do something 'interesting' by modifying
> the cpu_resume code since it's writable if I was a malicious
> program.

Even moving the cpu_resume function into the text section doesn't
prevent a malicious program which can write to the sleep_save_sp area to
use a different resume function. I suppose that is a bit harder to do
though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

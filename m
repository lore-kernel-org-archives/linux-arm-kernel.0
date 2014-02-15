From: Catalin.Marinas@arm.com (Catalin Marinas)
Date: Sat, 15 Feb 2014 10:28:15 +0000
Subject: [PATCH] ARM64: unwind: Fix PC calculation
In-Reply-To: <1392406515-27835-1-git-send-email-olof@lixom.net>
References: <1392406515-27835-1-git-send-email-olof@lixom.net>
Message-ID: <BBC3AB9B-17A9-4112-B8CC-D3DCB3B673D9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 Feb 2014, at 19:35, Olof Johansson <olof@lixom.net> wrote:
> The frame PC value in the unwind code used to just take the saved LR
> value and use that.  That's incorrect as a stack trace, since it shows
> the return path stack, not the call path stack.
>
> In particular, it shows faulty information in case the bl is done as
> the very last instruction of one label, since the return point will be
> in the next label. That can easily be seen with tail calls to panic(),
> which is marked __noreturn and thus doesn't have anything useful after it.
>
> Easiest here is to just correct the unwind code and do a -4, to get the
> actual call site for the backtrace instead of the return site.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: stable at vger.kernel.org

Looks fine. I?ll push it sometime next week. Thanks.

Catalin

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782

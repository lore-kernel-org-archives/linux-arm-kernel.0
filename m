From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Oct 2016 19:26:37 +0100
Subject: [PATCH] arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y
In-Reply-To: <CAKv+Gu-sdgkoQvbpgHXZmDyxg6NTGJpC+hsqzdbwTkny+TeqfA@mail.gmail.com>
References: <1476376929-29688-1-git-send-email-ard.biesheuvel@linaro.org>
 <57FFE78E.4040002@codeaurora.org>
 <CAKv+Gu-sdgkoQvbpgHXZmDyxg6NTGJpC+hsqzdbwTkny+TeqfA@mail.gmail.com>
Message-ID: <20161014182637.GF6534@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 07:23:15PM +0100, Ard Biesheuvel wrote:
> On 13 October 2016 at 20:59, Timur Tabi <timur@codeaurora.org> wrote:
> > Ard Biesheuvel wrote:
> >>
> >> As it turns out, the KASLR code breaks CONFIG_MODVERSIONS, since the
> >> kcrctab has an absolute address field that is relocated at runtime
> >> when the kernel offset is randomized.
> >>
> >> This has been fixed already for PowerPC in the past, so simply wire up
> >> the existing code dealing with this issue.
> >>
> >> Signed-off-by: Ard Biesheuvel<ard.biesheuvel@linaro.org>
> >
> >
> > Tested-by: Timur Tabi <timur@codeaurora.org>
> >
> 
> Thanks. I will resend this with a fixes: tag and a better description

Feel free, but I already queued it locally and added the Fixes tag myself.
I'm just waiting for Lorenzo to post a fix to the ACPI NUMA stuff, then
I'll send these two up together next week.
Will

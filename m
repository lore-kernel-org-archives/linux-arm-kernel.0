From: bp@alien8.de (Borislav Petkov)
Date: Thu, 19 Nov 2015 16:51:58 +0100
Subject: [PATCH RFC v2] apei: Add ACPI APEI event notification support
In-Reply-To: <F77E0D1A-FE01-4BA8-B72C-AA6CB7DAD61C@redhat.com>
References: <1445458480-6493-1-git-send-email-lho@apm.com>
 <20151022095716.GC3671@pd.tnic> <20151119141816.GH22786@arm.com>
 <F77E0D1A-FE01-4BA8-B72C-AA6CB7DAD61C@redhat.com>
Message-ID: <20151119155158.GE6065@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 10:05:16AM -0500, Jon Masters wrote:
> Top post - quick reply - you are correct. This is a vendor specific
> implementation. APEI is generic, and in the general case there should
> not be a need to do anything with a special driver. Some will need
> their own special solution in the early days, but everyone else should
> be able to go generic. In particular I expect those implementing EL3
> to do firmware first handling and to signal the event independently of
> any OS specific hooks.

In the meantime, I got these two patches:

https://lkml.kernel.org/r/1446857519-5908-1-git-send-email-lho at apm.com

which makes the GHES IRQ shared and, apparently solves the issue for
APM.

I'd appreciate it if you guys took a look.

Thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

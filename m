From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Fri, 07 May 2010 23:27:02 +0300
Subject: [GIT-PULL] ARM: Gemini: fix compiler error in copypage-fa.c
In-Reply-To: <alpine.LNX.2.00.1005071325450.7857@localhost>
References: <1272983655-18408-1-git-send-email-ulli.kroll@googlemail.com>
	<20100504160522.GD30601@n2100.arm.linux.org.uk>
	<alpine.LNX.2.00.1005071325450.7857@localhost>
Message-ID: <4BE47796.1010109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2010 02:30 PM, Hans Ulli Kroll wrote:
> Here you call pull ...

Hmm... Please include original message (or par of it) when replying.
It was from Russell:

 > Ok.  Please submit to the patch system, thanks.

His patch system is at http://www.arm.linux.org.uk/developer/patches/
He may however pull from your branch. It is up to him.

Other thing...

I see you have some interest in gemini (from personal e-mails).
Maybe you would like/agree to take maintainership from me?
I am fully open and I promise to help you with any questions about
gemini, but I have no hardware and my priorities are different now.

Paulius

> Ulli
>
> The following changes since commit
> 352d4657b23fbd329efccc396000a549e0150907:
> Linus Torvalds (1):
> Merge branch 'for-linus' of git://git.kernel.org/.../mattst88/alpha-2.6
>
> are available in the git repository at:
>
> git://git.berlios.de/gemini-board gemini_fix
>
> Hans Ulli Kroll (1):
> ARM: Gemini: fix compiler error in copypage-fa.c
>
> arch/arm/mm/copypage-fa.c | 2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> index b2a6008..d2852e1 100644
> --- a/arch/arm/mm/copypage-fa.c
> +++ b/arch/arm/mm/copypage-fa.c
> @@ -40,7 +40,7 @@ fa_copy_user_page(void *kto, const void *kfrom)
> }
>
> void fa_copy_user_highpage(struct page *to, struct page *from,
> - unsigned long vaddr)
> + unsigned long vaddr, struct vm_area_struct *vma)
> {
> void *kto, *kfrom;
>
>

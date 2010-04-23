From: mmarek@suse.cz (Michal Marek)
Date: Fri, 23 Apr 2010 22:59:54 +0200
Subject: [PATCH] [ARM] .gitignore: Ignore piggy.lzo,
	lib1funcs.S and vmlinux
In-Reply-To: <1272015498-10749-1-git-send-email-mroth@nessie.de>
References: <1272015498-10749-1-git-send-email-mroth@nessie.de>
Message-ID: <4BD20A4A.7040408@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.4.2010 11:38, Michael Roth wrote:
> Commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c added LZO compressed
> kernels, lib1funcs.S is copied from the appropriate ARM sub-arch
> and vmlinux is the obvious fruit of all efforts.

vmlinux started to show up in 'git status' after 6db823c, which changed
vmlinux to /vmlinux in the top-level .gitignore.

BTW, there is already *.lzo in the top-level .gitignore in linux-next,
so you could omit piggy.lzo, but anyway

Acked-by: Michal Marek <mmarek@suse.cz>


> Signed-off-by: Michael Roth <mroth@nessie.de>
> ---
>  arch/arm/boot/compressed/.gitignore |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index ab204db..6dac3d0 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,6 @@
>  font.c
> +lib1funcs.S
>  piggy.gz
> +piggy.lzo
> +vmlinux
>  vmlinux.lds

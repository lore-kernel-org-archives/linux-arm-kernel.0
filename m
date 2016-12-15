From: victor.chong@linaro.org (Victor Chong)
Date: Thu, 15 Dec 2016 12:55:26 +0900
Subject: [PATCH] builddeb: Use aarch64 instead of arm64 for UTS_MACHINE
In-Reply-To: <1481280644-15614-1-git-send-email-will.deacon@arm.com>
References: <1481280644-15614-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAHqM-QiF3i7a42M9fXq4myRCXSu3yrSgY6fmpCu0KZdedSJ6-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Just found out that a similar patch was submitted earlier back in Nov.

https://patchwork.kernel.org/patch/9444665/

Thanks!

On Fri, Dec 9, 2016 at 7:50 PM, Will Deacon <will.deacon@arm.com> wrote:
> From: Michal Marek <mmarek@suse.com>
>
> On arm64-based systems, uname -m reports "aarch64", so this is what
> we should be using for UTS_MACHINE and matching that in the builddeb
> script instead of "arm64".
>
> There was a patch fixing this:
>
>   https://patchwork.kernel.org/patch/9305483/
>
> but I accidentally merged v1 of the patch, which omitted the update to
> builddeb. This patch follows up with that missing hunk.
>
> Reported-by: Victor Chong <victor.chong@linaro.org>
> Signed-off-by: Michal Marek <mmarek@suse.com>
> [will: salvaged missing hunk from original patch]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  scripts/package/builddeb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 8ea9fd2b6573..9530b1634a02 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -51,7 +51,7 @@ set_debarch() {
>                 debarch=hppa ;;
>         mips*)
>                 debarch=mips$(grep -q CPU_LITTLE_ENDIAN=y $KCONFIG_CONFIG && echo el || true) ;;
> -       arm64)
> +       aarch64*)
>                 debarch=arm64 ;;
>         arm*)
>                 if grep -q CONFIG_AEABI=y $KCONFIG_CONFIG; then
> --
> 2.1.4
>

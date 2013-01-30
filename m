From: richard.genoud@gmail.com (Richard GENOUD)
Date: Wed, 30 Jan 2013 16:40:52 +0100
Subject: [PATCH] ARM:boot: support the command with COMMAND_LINE_SIZE - 1
 useful chars
In-Reply-To: <510912D5.5030505@asianux.com>
References: <510912D5.5030505@asianux.com>
Message-ID: <20130130154051.GA18119@lnx-rg.pr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On [mer., 30.01.2013 20:32:21], Chen Gang wrote:
> 
>   originally, not support the command with COMMAND_LINE_SIZE - 1 useful chars.
>   but in fact, we can support it:
> 
You're right.
Reviewed-by: Richard Genoud <richard.genoud@gmail.com>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/boot/compressed/atags_to_fdt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> index aabc02a..ed23ec2 100644
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -63,7 +63,7 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
>  	/* copy the fdt command line into the buffer */
>  	fdt_bootargs = getprop(fdt, "/chosen", "bootargs", &len);
>  	if (fdt_bootargs)
> -		if (len < COMMAND_LINE_SIZE) {
> +		if (len <= COMMAND_LINE_SIZE) {
>  			memcpy(ptr, fdt_bootargs, len);
>  			/* len is the length of the string
>  			 * including the NULL terminator */
> @@ -73,7 +73,7 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
>  	/* and append the ATAG_CMDLINE */
>  	if (fdt_cmdline) {
>  		len = strlen(fdt_cmdline);
> -		if (ptr - cmdline + len + 2 < COMMAND_LINE_SIZE) {
> +		if (ptr - cmdline + len + 2 <= COMMAND_LINE_SIZE) {
>  			*ptr++ = ' ';
>  			memcpy(ptr, fdt_cmdline, len);
>  			ptr += len;
> -- 
> 1.7.10.4

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Jun 2015 15:42:39 +0100
Subject: [RFC][PATCH] arm64:Modify the dump mem for 64 bit addresses
In-Reply-To: <1434605226-17084-1-git-send-email-maninder1.s@samsung.com>
References: <1434605226-17084-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20150618144239.GD31480@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 10:57:06AM +0530, Maninder Singh wrote:
> From: Rohit Thapliyal <r.thapliyal@samsung.com>
> 
> On 64bit kernel, the dump_mem gives 32 bit addresses
> on the stack dump. This gives unorganized information regarding
> the 64bit values on the stack. Hence, modified to get a complete
> 64bit memory dump.
[...]
> The above output makes a debugger life a lot more easier.
> 
> Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com> 
> ---
>  arch/arm64/kernel/traps.c |   62 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 1ef2940..6e9f19b 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -51,6 +51,48 @@ int show_unhandled_signals = 1;
>  /*
>   * Dump out the contents of some memory nicely...
>   */
> +
> +static void dump_mem64(const char *lvl, const char *str, unsigned long bottom,
> +		unsigned long top)

While I'm not against the idea, can you not add a "width" or "wide"
argument to the dump_mem() function and share the code? This function is
very similar to the original dump_mem() implementation and it would be
nice to avoid some code duplication.

-- 
Catalin

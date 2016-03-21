From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 21 Mar 2016 16:38:36 +0100
Subject: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160321153836.GZ6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48958d3cec9e..37afd721ec99 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -887,8 +887,8 @@ static void check_section(const char *modname, struct elf_info *elf,
>  #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>  
>  #define DATA_SECTIONS ".data", ".data.rel"
> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
> -		".kprobes.text"
> +#define TEXT_SECTIONS ".text", ".text.unlikely", \
> +		".kprobes.text", ".cpuidle.text"

Where did .sched.text go?

>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
>  		".fixup", ".entry.text", ".exception.text", ".text.*", \
>  		".coldtext"

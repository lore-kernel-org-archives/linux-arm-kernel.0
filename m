From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 23 Nov 2010 09:32:45 -0500
Subject: [PATCHv2 1/2] ftrace: ignore any ftrace.o in C version of
	recordmcount
In-Reply-To: <1290521691-5101-1-git-send-email-rabin@rab.in>
References: <1290454387.30543.304.camel@gandalf.stny.rr.com>
	<1290521691-5101-1-git-send-email-rabin@rab.in>
Message-ID: <1290522765.30543.307.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do you want to push these through the arm tree. It may be easier that
way.

You can add my:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

to both patches.

-- Steve


On Tue, 2010-11-23 at 19:44 +0530, Rabin Vincent wrote:
> arch/arm/kernel/ftrace.c references mcount like kernel/tracing/ftrace.c,
> so change the exclusion filter to match any ftrace.o.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  scripts/recordmcount.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index f2f32ee..ac6e51c 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -357,7 +357,7 @@ do_file(char const *const fname)
>  int
>  main(int argc, char const *argv[])
>  {
> -	const char ftrace[] = "kernel/trace/ftrace.o";
> +	const char ftrace[] = "/ftrace.o";
>  	int ftrace_size = sizeof(ftrace) - 1;
>  	int n_error = 0;  /* gcc-4.3.0 false positive complaint */
>  

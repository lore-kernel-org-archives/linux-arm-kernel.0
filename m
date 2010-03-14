From: rostedt@goodmis.org (Steven Rostedt)
Date: Sun, 14 Mar 2010 12:56:16 -0400
Subject: [PATCH 08/10] ARM: ftrace: fix and update dynamic ftrace
In-Reply-To: <1268462987-8271-9-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-9-git-send-email-rabin@rab.in>
Message-ID: <1268585776.13400.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-03-13 at 12:19 +0530, Rabin Vincent wrote:
> This adds mcount recording and updates dynamic ftrace for ARM to work
> with the new ftrace dyamic tracing implementation.  It also adds support
> for the mcount format used by newer ARM compilers.
> 
> With dynamic tracing, mcount() is implemented as a nop.  Callsites are
> patched on startup with nops, and dynamically patched to call to the
> ftrace_caller() routine as needed.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.i


> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index f3c9c0a..319af1e 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -268,6 +268,8 @@ if ($arch eq "x86_64") {
>  } elsif ($arch eq "arm") {
>      $alignment = 2;
>      $section_type = '%progbits';
> +    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_ARM_(CALL|PC24)" .
> +			"\\s+(__gnu_mcount_nc|mcount)\$";
>  
>  } elsif ($arch eq "ia64") {
>      $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

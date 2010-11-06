From: catalin.marinas@gmail.com (Catalin Marinas)
Date: Sat, 6 Nov 2010 19:06:28 +0000
Subject: [PATCH 6/6] ARM: ftrace: enable function graph tracer
In-Reply-To: <1289067954-5080-6-git-send-email-rabin@rab.in>
References: <1289067954-5080-1-git-send-email-rabin@rab.in>
	<1289067954-5080-6-git-send-email-rabin@rab.in>
Message-ID: <AANLkTin8UO9ixVep0jKK8H5roWEVRDJW4khUpT2TpPs+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, November 6, 2010, Rabin Vincent <rabin@rab.in> wrote:
> Add the options to enable the function graph tracer on ARM. ?Function
> graph tracer support requires frame pointers, so exclude Thumb-2 and
> also explicitly select FRAME_POINTER in FUNCTION_GRAPH_TRACER since
> FUNCTION_TRACER doesn't select FRAME_POINTER when ARM_UNWIND is used
> Therefore, with GCC 4.4.0+, you get plain function tracing without frame
> pointers, but you'll need them if you want function graph tracing.
.....
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -141,6 +141,7 @@ config FUNCTION_TRACER
>
> ?config FUNCTION_GRAPH_TRACER
>  ? ? ? ?bool "Kernel Function Graph Tracer"
> + ? ? ? select FRAME_POINTER if ARM_UNWIND

Would it be better to modify FRAME_POINTER definition in the ARM
Kconfig so that it is enabled automatically when FUNCTION_GRAPH_TRACER
is enabled?

-- 
Catalin

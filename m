From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Nov 2010 10:18:58 +0100
Subject: [PATCH 6/6] ARM: ftrace: enable function graph tracer
In-Reply-To: <AANLkTin8UO9ixVep0jKK8H5roWEVRDJW4khUpT2TpPs+@mail.gmail.com>
References: <1289067954-5080-1-git-send-email-rabin@rab.in>
	<1289067954-5080-6-git-send-email-rabin@rab.in>
	<AANLkTin8UO9ixVep0jKK8H5roWEVRDJW4khUpT2TpPs+@mail.gmail.com>
Message-ID: <20101108091858.GP16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 06, 2010 at 07:06:28PM +0000, Catalin Marinas wrote:
> On Saturday, November 6, 2010, Rabin Vincent <rabin@rab.in> wrote:
> > Add the options to enable the function graph tracer on ARM. ?Function
> > graph tracer support requires frame pointers, so exclude Thumb-2 and
> > also explicitly select FRAME_POINTER in FUNCTION_GRAPH_TRACER since
> > FUNCTION_TRACER doesn't select FRAME_POINTER when ARM_UNWIND is used
> > Therefore, with GCC 4.4.0+, you get plain function tracing without frame
> > pointers, but you'll need them if you want function graph tracing.
> .....
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -141,6 +141,7 @@ config FUNCTION_TRACER
> >
> > ?config FUNCTION_GRAPH_TRACER
> >  ? ? ? ?bool "Kernel Function Graph Tracer"
> > + ? ? ? select FRAME_POINTER if ARM_UNWIND
> 
> Would it be better to modify FRAME_POINTER definition in the ARM
> Kconfig so that it is enabled automatically when FUNCTION_GRAPH_TRACER
> is enabled?
I don't like that suggestion much because it hides the dependency.
Moreover a "default y if FUNCTION_GRAPH_TRACER" doesn't work if a
precondition for FRAME_POINTER isn't true.  Rabin's approach at least
generates a warning.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

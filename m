From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Oct 2010 10:26:21 -0400 (EDT)
Subject: [PATCH 1/3] [ARM] Translate delay.S into (mostly) C
In-Reply-To: <4CABEECB.4030301@codeaurora.org>
References: <1285644827-6846-1-git-send-email-sboyd@codeaurora.org>
	<1285644827-6846-2-git-send-email-sboyd@codeaurora.org>
	<1286299355.18791.11.camel@c-dwalke-linux.qualcomm.com>
	<4CABEECB.4030301@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1010061024220.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Oct 2010, Stephen Boyd wrote:

>  On 10/05/2010 10:22 AM, Daniel Walker wrote:
> > I think the "size" command might be better for this type of stuff. It
> > should give you the same output (or similar).. It's just used more
> > frequently. 
> 
> Ok.
> 
> $ size vmlinux.orig
>    text    data     bss     dec     hex filename
> 6533503  530232 1228296 8292031  7e86bf vmlinux.orig
> $ size vmlinux.new
>    text    data     bss     dec     hex filename
> 6533607  530232 1228296 8292135  7e8727 vmlinux.new

If you modified only one source file then I'd suggest you run 'size' 
only on the affected .o file instead.


Nicolas

From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 10:44:22 +0100
Subject: [PATCH 3/9] lpc2k: clk API
In-Reply-To: <083DF309106F364B939360100EC290F80B15AC2B3B@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-4-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15AC2B3B@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300441462.2138.129.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, 2011-03-17 at 23:08 +0100, Kevin Wells wrote:
> > +static DEFINE_MUTEX(clocks_mutex);
> 
> I tried this lock mechanism and occasionally I get warnings when mutex
> checking is enabled and multiple calls occur to the clk_* functions
> with active clock management. Spinlocks might be better, but maybe
> some one else can chime in here.

Looking at the other mach-*/clock.c implementations, most seem to agree
on spinlocks. Will change for v2.

Regards,

Ithamar.

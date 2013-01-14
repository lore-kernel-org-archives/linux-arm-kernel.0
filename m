From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 17:24:01 +0000
Subject: [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of
 a dying CPU is disabled
In-Reply-To: <alpine.LFD.2.02.1301141216020.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-9-git-send-email-nicolas.pitre@linaro.org>
 <20130114163902.GC31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141154130.6300@xanadu.home>
 <20130114170210.GE31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141216020.6300@xanadu.home>
Message-ID: <20130114172401.GG31341@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:18:24PM +0000, Nicolas Pitre wrote:
> On Mon, 14 Jan 2013, Will Deacon wrote:
> > Sorry! This case is more interesting though, because you also want to order
> > the cpu_if_down GIC write so that it completes before we do the power_off.
> 
> In this case I'm leaning toward removing that gic_cpu_if_down() 
> entirely.  I'm not convinced it is necessary, and if it is then we 
> probably have a bug somewhere else.

Or that :)

Will

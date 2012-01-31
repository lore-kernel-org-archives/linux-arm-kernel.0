From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 31 Jan 2012 01:14:53 -0700 (MST)
Subject: [PATCH 0/7] ARM: OMAP2+: hwmod/timer: first set of cleanups for
 3.4
In-Reply-To: <4F27A0B0.50704@ti.com>
References: <20120130101251.10450.58423.stgit@dusk> <87ty3cpyuk.fsf@ti.com>
 <4F27A0B0.50704@ti.com>
Message-ID: <alpine.DEB.2.00.1201310111300.10061@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 31 Jan 2012, Cousson, Benoit wrote:

> Thanks to the L3 log error:
> [    0.838439] L3 custom error: MASTER:DucatiM3 TARGET:GPMC
> 
> I guess that I understand why I was not releasing the hardreset at boot time
> before:-)
> 
> DSP and CortexM3 cannot be released from reset until someone loaded a firmware
> in memory. Otherwise they will start executing some random instructions that
> in this case are trying to access an area that is not accessible.
> 
> We have to let the driver handle the hardreset because it is mainly used for
> processors.

Currently we're not asserting hardreset in the hwmod code during _reset().  
I had that patch in the series at some point, but took it out before 
posting it.  So maybe that might resolve this particular issue.  Also 
sounds like we should make sure that we keep the processor IPs in 
hardreset until some driver explicitly releases it; we'll need to make 
sure the code does that too.


- Paul

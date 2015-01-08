From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 8 Jan 2015 21:55:08 +0800
Subject: [RFC] how to implement suspend to ram for arm64?
In-Reply-To: <20150108125921.GB1823@red-moon>
References: <20150108195408.01a8dfdb@xhacker> <20150108125921.GB1823@red-moon>
Message-ID: <20150108215508.71e95b7b@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lorenzo,

On Thu, 8 Jan 2015 05:49:26 -0800
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> Hi Jisheng,
> 
> On Thu, Jan 08, 2015 at 11:54:08AM +0000, Jisheng Zhang wrote:
> > Hi list,
> > 
> > we need the suspend to ram feature on arm64. And I think the fundamental
> > code is ready, for example  __cpu_suspend() etc.
> > 
> > However, there are several issues need to be resolved...
> > 
> > 1. where to put platform_suspend_ops implementation? drivers/power?
> > 
> > 2. If the "put ddr to self refresh" code must be in EL3 or secure EL1, how
> > linux tell the firmware to trigger it? extend PSCI or use the context_id
> > of PSCI CPU_SUSPEND function?
> > 
> > 3. where to put the cod of invoke suspend_to_ram psci call?
> 
> We are working on all the items you mentioned above, inclusive of a PSCI
> spec update.
> 
> I will make sure we post the required code on the lists shortly, and keep
> you in the loop.
> 

Wow, great! Thank you very much. I have an ugly hack in private repo to support
this feature. I'm sure the hack will be definitely rejected :D 

Looking forward to the beautiful standard solution!

Thanks,
Jisheng

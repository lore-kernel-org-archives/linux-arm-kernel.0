From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Sep 2015 09:48:14 +0100
Subject: [PATCH] arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <20150831132031.2a017df1@arm.com>
References: <55E1AD09.7020701@huawei.com> <55E1CBE9.6080705@linux.intel.com>
 <66e158e6da958d355d54543ef69e5e94@www.loen.fr>
 <55E3020C.8020303@linaro.org> <20150831132031.2a017df1@arm.com>
Message-ID: <20150901084814.GB1612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 01:20:31PM +0100, Marc Zyngier wrote:
> On Sun, 30 Aug 2015 21:15:56 +0800
> Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > I agree. In arch/arm64/kernel/irq.c the irq migrate code is the same
> > as ARM32, and it's duplicate. But this is a bugfix, can we fix it in
> > a simple way, and refactor the code later?
> 
> I'm not buying this.
> 
> I really can't see how adding more duplication can be beneficial. It is
> not so much that there is duplication between arm and arm64 that
> bothers me (as if that was the only thing...). The real issue is that
> there is duplication between the arch code and the core code.
> 
> Migrating interrupts is a core code matter, and that's were it should
> be handled IMHO. Plus, we're in the merge window, and there is plenty
> of time to get this fixed the proper way.

Yup. I suggested this over a year ago but not sure why nothing happened:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266923.html

Will

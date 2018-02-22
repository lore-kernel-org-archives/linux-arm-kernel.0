From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 10:56:41 +0100
Subject: [PATCH v4 03/40] KVM: arm64: Avoid storing the vcpu pointer on
 the stack
In-Reply-To: <20180222091034.GD29376@cbox>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-4-christoffer.dall@linaro.org>
 <20180221173200.6vfv6a4hytibos3p@kamzik.brq.redhat.com>
 <20180222091034.GD29376@cbox>
Message-ID: <20180222095641.w5isy5jt5a67jocp@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 10:10:34AM +0100, Christoffer Dall wrote:
> On Wed, Feb 21, 2018 at 06:32:00PM +0100, Andrew Jones wrote:
> > 
> > Besides my confusion on motivation, it looks good to me
> > 
> 
> In that case, unless there's an argument that the code has become too
> hard to understand, ...
>

On the contrary, I think it's easier to read now than before. I just
wasn't clear how it all tied together with this series. If its
combination with other patches enables a speedup, then it certainly
fits here. I was just comparing mrs+loads vs. a load from stack and
it seemed it would actually cause a micro-performance-decrease.

Thanks,
drew

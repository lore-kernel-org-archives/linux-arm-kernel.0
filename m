From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 2 May 2013 18:19:25 +0100
Subject: [PATCH] ARM: KVM: Don't handle PSCI calls via SMC
In-Reply-To: <CAEDV+gK27-vw-RhcSrQsrJUfJx_zKQXtc6R6JGVg=YDsQmWZHA@mail.gmail.com>
References: <1367426968-5577-1-git-send-email-Dave.Martin@arm.com>
 <CAEDV+gK27-vw-RhcSrQsrJUfJx_zKQXtc6R6JGVg=YDsQmWZHA@mail.gmail.com>
Message-ID: <20130502171925.GB9879@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 10:59:13AM -0700, Christoffer Dall wrote:
> On Wed, May 1, 2013 at 9:49 AM, Dave P Martin <Dave.Martin@arm.com> wrote:
> > Currently, kvmtool unconditionally declares that HVC should be used
> > to call PSCI, so the function numbers in the DT tell the guest
> > nothing about the function ID namespace or calling convention for
> > SMC.
> >
> > We already assume that the guest will examine and honour the DT,
> > since there is no way it could possibly guess the KVM-specific PSCI
> > function IDs otherwise.  So let's not encourage guests to violate
> > what's specified in the DT by using SMC to make the call.
> >
> > Signed-off-by: Dave P Martin <Dave.Martin@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks, applied.
> 
> -Christoffer

Thanks
---Dave

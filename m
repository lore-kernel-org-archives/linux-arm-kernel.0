From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Oct 2013 09:07:56 +0100
Subject: [PATCH 3/3] KVM: ARM: Add support for Cortex-A7
In-Reply-To: <CA+eFSM0k3mA4uOiEvmE_tfVjnpq8DpXV-=nJXhucUDePJRTYXw@mail.gmail.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
 <1380210568-23175-4-git-send-email-jonathan.austin@arm.com>
 <20130926161743.GD1389@cbox>	<52446A48.9070501@arm.com>
 <CA+eFSM1YdhBDMAvyXknMA62Ao3CEntMptdi7RD=NXis1F-BmfQ@mail.gmail.com>
 <CAFEAcA9muNxMtSQHqrByk6Gjw4iWS=vF33T=R42tvAQSTLiAeA@mail.gmail.com>
 <CA+eFSM0k3mA4uOiEvmE_tfVjnpq8DpXV-=nJXhucUDePJRTYXw@mail.gmail.com>
Message-ID: <52526BDC.3050305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/13 07:16, Gavin Guo wrote:
> On Sun, Oct 6, 2013 at 10:56 PM, Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> wrote:
> 
>     On 6 October 2013 23:03, Gavin Guo <gavin.guo@canonical.com
>     <mailto:gavin.guo@canonical.com>> wrote:
>     > Does it mean the currently qemu can't support A15 vcpu running on
>     host A7?
> 
>     No, that's a kernel restriction. That is why the patch description
>     reads:
>     # This patch adds support for running Cortex-A7 guests on Cortex-A7
>     hosts.
> 
>     (What QEMU is currently missing is A7 support, so you can't ask it to
>     run an A7 guest CPU.)
> 
>     -- PMM
> 
> 
> Thanks, I saw the checking in the kvm_vcpu_set_target(). I'm confused
> that what is the concern to run the same cpu type? Does it matter to run
> A15 on A7 or inverse?

It does. MIDR registers are different. Cache size is different. It may
work, or it may not. And at the very least, you should present a
consistent view of the underlying system to the unsuspecting OS.

	M.
-- 
Jazz is not dead. It just smells funny...

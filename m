From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 4 Jul 2016 13:06:54 +0200
Subject: Build regressions/improvements in v4.7-rc6
In-Reply-To: <6183003.0tbSMroAbk@wuerfel>
References: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUDO0k86TTVTiCQGS2=H0dEXVW77NNfvt7fvWbwdpS=2g@mail.gmail.com>
 <6183003.0tbSMroAbk@wuerfel>
Message-ID: <f2b404d1-5212-8698-c8dd-c94e34160a70@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/07/2016 11:17, Arnd Bergmann wrote:
> 
> If we want to avoid this one, we could make the inclusion of
> drivers/vhost/Kconfig from arch/arm/kvm/Kconfig depend on CONFIG_AEABI,
> or perhaps go further force-enable CONFIG_AEABI for ARMv6k and higher
> (cmpxchg64() is broken on OABI too), and only include vhost if KVM
> is enabled (KVM in turn requires ARMv7).

I don't think it is correct to include vhost only if KVM is enabled.
vhost is an implementation of virtio; it is usually used together with
KVM but there's no dependency between the two.

Paolo

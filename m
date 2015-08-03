From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Aug 2015 18:06:56 +0100
Subject: [PATCH v2 14/15] KVM: arm64: implement MSI injection in ITS
 emulation
In-Reply-To: <55BF8AB8.5050408@linaro.org>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-15-git-send-email-andre.przywara@arm.com>
 <55BB7678.5080105@linaro.org> <55BE7BA1.40403@arm.com>
 <00a201d0cdb7$70a623f0$51f26bd0$@samsung.com> <55BF2F51.6020701@linaro.org>
 <00f101d0cdcd$146a6090$3d3f21b0$@samsung.com> <55BF8AB8.5050408@linaro.org>
Message-ID: <55BF9FB0.6070804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/15 16:37, Eric Auger wrote:
> Andre, Pavel,
> On 08/03/2015 11:16 AM, Pavel Fedin wrote:
>>  Hello!
>>
>>> Again the case that leaves me uncomfortable is the one where the
>>> userspace does not provide the devid whereas it must (GICv3 ITS case).
>>
>>  Hypothetical broken userland which does not exist for now ?
> Yes but that's the rule to be not confident in *any* userspace, isn't it?
> 
> As of now I prefer keeping the flags at uapi level and propagate it
> downto the kernel, as long as I don't have any answer for the unset
> devid discrimination question. Please apologize for my stubbornness ;-)

I think this flag should be kept, as it really indicates what is valid
in the MSI structure. It also has other benefits such as making obvious
what userspace expects, which can then be checked against the kernel's
own expectations.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

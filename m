From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed, 09 Apr 2014 12:04:58 +0300
Subject: Big endian working?
In-Reply-To: <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
References: <20140408095446.0520dd28@skate>	<5343BDEE.4010005@linaro.org>	<12950765.TpxjkTx5NP@wuerfel>	<alpine.LFD.2.11.1404082339291.1571@knanqh.ubzr>
 <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
Message-ID: <53450D3A.7030909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2014 07:46 AM, Victor Kamensky wrote:
> My understanding is that CPU_BE8_BOOT_LE was needed only for
> atags boot case. Since now practically nobody uses atags, but rather
> fdt those patches were not pushed into main stream.
>
> Please look at
> git://git.baserock.org/delta/linux baserock/311-rc7/be/atags-v2
>
> Thomas, does your Armada XP uboot still uses atags? I would think
> not.
>
> I can confirm that in main line TC2 works in BE mode without any
> changes. In linaro kernel tree we have Arandle and Pandaboard with
> additional, drivers only changes, and they work OK. However I don't
> think we are testing zImage, in all cases I use it, it is uImage.

Actually I usually use zImage, so I do need these patches :)
 From IRC discussion on Tom's issue I thought that he also have zImage.

> Maybe Nico's zImage change was under atags umbrella by mistake and
> it really addresses general zImage issue. In this case we need to add
> this commit to main line. However, I don't think we need to carry
> CPU_BE8_BOOT_LE option forward, why we just use
> CONFIG_CPU_BIG_ENDIAN instead. Note in all cases when BE
> image used loader is always in LE mode. Never seen case
> otherwise.

That makes sense, but I'm concerned about BE32 systems.
Do they also have LE bootloaders? I don't remember kernel code which
switches to BE32. I'd think that switch is done by bootloader or 
ROMcode. Or even BE hardwired in HW. So BE32 bootloader may expect to
see BE zImage header.
Maybe instead of CONFIG_CPU_BIG_ENDIAN use CONFIG_CPU_ENDIAN_BE8?

-- 
Taras Kondratiuk

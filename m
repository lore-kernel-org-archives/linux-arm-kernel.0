From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 7 Jan 2015 09:06:30 +0100
Subject: [PATCH 1/4] ARM: tegra: rely on bootloader pinmux programming on
 nyan-big
In-Reply-To: <54AC16B0.5050703@wwwdotorg.org>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
 <1420540653-14816-2-git-send-email-tomeu.vizoso@collabora.com>
 <54AC16B0.5050703@wwwdotorg.org>
Message-ID: <CAAObsKB1gMcLZ=n8Mc6JSLQHn5-6VWOhERLgYTdi6nit6yCj5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2015 at 18:09, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/06/2015 03:37 AM, Tomeu Vizoso wrote:
>>
>> Following 6dbaff2b, the kernel expects that the bootloader has correctly
>> programmed the Tegra pinmux.
>>
>> DTs for the Jetson and the Venice2 had been updated already but this one
>> was left behind.
>
>
> So this setup is true for NVIDIA-controlled development/reference boards
> where we've ensured that the bootloader sets up 100% of the pinmux.
>
> However, I know that Coreboot on this board doesn't set up everything in the
> pinmux, and since it's in r/o flash never will. As such, I'm not sure this
> change is safe for this board. That is, unless you want to force upstream
> kernels to be booted via a chain-loaded path: Coreboot (r/o) -> U-Boot (r/w
> with full pinmux setup) -> kernel.
>
>> Have tested this with the stock vendor firmware (coreboot) and have found
>> no
>> issues.
>
>
> There are presumably a bunch of features which aren't yet supported
> upstream, and hence you couldn't test though? That means we might find that
> parts of the pinmux aren't yet programmed but need to be to enable those
> features.

Sure, there's no chance that my testing could have been extensive enough.

Following Andrew's feedback, I will be looking at getting the pinmux
programming right in the DTs.

Thanks,

Tomeu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

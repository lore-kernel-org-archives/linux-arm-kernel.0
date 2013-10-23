From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Oct 2013 12:28:09 +0100
Subject: [Add SMP support for Allwinner A20: PATCH V5 3/3] Add arch count
 timer node in dts for Allwinner A20(sunxi 7i).
In-Reply-To: <1382027827-10080-4-git-send-email-cinifr@gmail.com>
References: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
 <1382027827-10080-4-git-send-email-cinifr@gmail.com>
Message-ID: <20131023112809.GX3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:37:07AM +0800, Fan Rong wrote:
> Linux kernel usually use virtual arch timer for smp cpu tick. But the
> arch timer register VCTOFF normally is very different between the two
> cpus in A20 afer hardware reset, so SMP Cpus will see different time
> tick. It will cause kernel crash currently. You have two choices to
> fix it: 1 Simpley use physical arch timer, 2 Set VCTOFF to same value
> for each cpu in bootloader. The first choice will cause some other
> problem for kernel, especially for KVM, guest OS want to use virtual
> arch timer. So the second choice is perfect. So if you want to use
> arch timer for smp cpu tick, you must ensure you bootload have set
> same VCTOFF for all cpus.
> 

Is your patchset working without that last patch?

I'm not really wanting to apply it right now.

It relies on a bootloader behaviour that is not implemented by any
bootloader we have openly available right now. I will apply it after
it's been merged in at least u-boot-sunxi.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/dd85d6b0/attachment-0001.sig>

From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 26 Jun 2014 19:04:19 +0200
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
References: <539fdd37.e7bc420a.76b9.ffffb583@mx.google.com>	<CAGa+x85nqPbH-sye28ni=gUEdgjGdUDqHhv1+0pV5aO8y1+wHQ@mail.gmail.com>	<53A106F1.10201@gmail.com>	<CAGa+x8527FEPk6fg5kv-fbOzK3MzcFooFGE9Me12b9C_Pv=UzA@mail.gmail.com>	<53A2AE11.2050208@gmail.com>	<53A2BE94.2010308@gmail.com>	<53A7A579.4010702@gmail.com>	<CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA@mail.gmail.com>	<53A9B99F.4040806@codeaurora.org>	<53A9FBB5.60709@codeaurora.org>	<53AABCF5.4050403@gmail.com>	<53AB45D1.90909@codeaurora.org>	<53ABC13C.8030908@gmail.com>
 <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
Message-ID: <53AC5293.90209@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin and Tushar,

Am 26.06.2014 16:59, schrieb Kevin Hilman:
>> IMO, the bug is in u-boot and we should fix that.
> 
> I agree that the u-boot bug needs to be fixed, and FWIW, I updated my
> u-boot and haven't seen the boot failure yet after several boots with
> next-20140625.

Could you clarify your test setup: Are you using the original InSignal
SPL [1] with just your own u-boot.bin? Or do you have access to some
newer Samsung-signed SPL?

> That being said, since it's not always feasible/practical to update
> u-boot, and when it comes down to it, this is still a kernel
> regression, we should also fix the kernel to sanity check the values
> coming from u-boot, like it was doing before.

Sounds good.

Apart from this memory issue here, I noticed that CPUs don't appear to
be in HYP mode for virtualization, which had required a signed SPL
update for the ODROID-XU [2]. And to me it looks as if there's no
Arndale Octa support in upstream U-Boot [3], no real maintenance on the
InSignal fork [4] and a policy of not cooperating with others [5].

Thanks,
Andreas

[1] http://forum.insignal.co.kr/viewtopic.php?f=6&t=3199
[2] http://forum.odroid.com/viewtopic.php?f=64&t=2778&start=40#p32581
[3]
http://git.denx.de/?p=u-boot.git;a=blob;f=boards.cfg;h=947f2bc5ba2794c94b3b2cea04664f005e025f9f;hb=HEAD#l286
[4] http://git.insignal.co.kr/insignal/arndale_octa-jb_mr1.1/u-boot/
[5] http://forum.insignal.co.kr/viewtopic.php?f=40&t=3613

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

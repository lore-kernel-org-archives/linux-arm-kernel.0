From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 8 Feb 2011 16:28:31 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <20110208162036.GA6188@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081311.52004.arnd@arndb.de>
	<20110208121334.GB22877@n2100.arm.linux.org.uk>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<20110208162036.GA6188@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimG78sKbtWArR6kD8zy-Yd16_z23CYWEVSKThc4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 8, 2011 at 4:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 02:45:51PM +0000, Dave Martin wrote:
>> If support for a v6K processor is included, we have no way to know
>> from preprocessor definitions whether a plain v6 processor is also to
>> be supported.
>
> Yes we do. ?See the v6 patches I've recently posted to various mailing
> lists.
>
> This patch series was created in the hope that it could be tested by a
> sufficient number of people so that it could go into -rc1 as at the
> moment, omap2plus_defconfig builds data-corrupting kernels.
>
> Unfortunately, the response was not as good as I was hoping - it's
> possible to count the number of testers on one hand. ?So it's now
> scheduled for the next merge window. ?What this means is that v2.6.37
> and v2.6.38 omap2plus_defconfig kernels _will_ _be_ _unsafe_ when run
> on SMP hardware, and will remain that way. ?If a fix is not suitable for
> -rc, it most certainly isn't suitable for -stable.
> What the patch set does demonstrate that we can know at preprocessor
> time that plain v6 processors should be supported along side v6k and
> v7.

Fair enough--- I hadn't fully understood the implications there, since
I'm not really working with the v6 case for now.  Adding a
CPU_V6/CPU_V6K distinction does seem to solve that specific problem.
Unfortunately, I'm not in a position to test that easily...

I think I will alter my OMAP Thumb-2 support patches to avoid the
generic wfi() macro for now -- simply to decouple the dependency
pending discussion about system*.h.  This can be fixed later, if
appropriate.

Cheers
---Dave

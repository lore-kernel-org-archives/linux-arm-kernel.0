From: bp@alien8.de (Borislav Petkov)
Date: Thu, 4 Oct 2018 19:34:16 +0200
Subject: [PATCH v6 05/18] ACPI / APEI: Make estatus queue a Kconfig symbol
In-Reply-To: <a562d7c4-2e74-3a18-7fb0-ba8f40d2dce4@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-6-james.morse@arm.com>
 <20181001175956.GF7269@zn.tnic>
 <a562d7c4-2e74-3a18-7fb0-ba8f40d2dce4@arm.com>
Message-ID: <20181004173416.GC5149@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 06:50:36PM +0100, James Morse wrote:
> I'm all in favour of letting the compiler work it out, but the existing ghes
> code has #ifdef/#else all over the place. This is 'keeping the style'.

Yeah, but this "style" is not the optimal one and we should
simplify/clean up and fix this thing.

Swapping the order of your statements here:

> The ACPI spec has four ~NMI notifications, so far the support for
> these in Linux has been selectable separately.

Yes, but: distro kernels end up enabling all those options anyway and
distro kernels are 90-ish% of the setups. Which means, this will get
enabled anyway and this additional Kconfig symbol is simply going to be
one automatic reply "Yes".

So let's build it in by default and if someone complains about it, we
can always carve it out. But right now I don't see the need for the
unnecessary separation...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

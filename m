From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 16 Apr 2011 13:11:56 +0900
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415154113.GE4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA84AAB.60601@gmail.com> <201104151640.01040.arnd@arndb.de>
	<20110415152643.GC4423@n2100.arm.linux.org.uk>
	<BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
	<20110415154113.GE4423@n2100.arm.linux.org.uk>
Message-ID: <BANLkTim_HWU28idaCFKgJLfxMuBwwb+Nig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

[CC Paul Mundt]

On Sat, Apr 16, 2011 at 12:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 15, 2011 at 09:32:01AM -0600, Grant Likely wrote:
>> Yes, once the infrastructure is in place, powerpc can do its own
>> migration to the new code. ?I vote for putting it in lib at the
>> outset.
>
> I don't agree with stuffing non-arch directories with code which people
> haven't already agreed should be shared. ?As I've already said, in my
> experience it's hard to get agreement in the first place and even when
> you can the API generally needs to be changed from what you first think
> would be reasonable.
>
> So, lets wait to see whether the SH folk reply.

The SH arch is using NUMA for on-chip SRAM on some CPUs, but for
SH-Mobile ARM we have no software support at this point.

The SH/ARM hardware has a bunch of different on-chip memories in
place, and they all have individual power management support through
both clock gating and power domains. I assume other vendors have
similar setups.

I'd like to have some refcounting in place for the SRAM code if
possible, which would trickle down to runtime pm get/put which in turn
would allow us to control the power dynamically. Not sure how easy
that would be to accomplish though.

Paul may have some ideas on how to share the code between ARM and SH.

Thanks,

/ magnus

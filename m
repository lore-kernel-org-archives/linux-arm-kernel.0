From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 2 May 2017 13:27:54 +0100
Subject: [PATCH] Remove ARM errata Workarounds 458693 and 460075
In-Reply-To: <20170418155725.GG27592@e104818-lin.cambridge.arm.com>
References: <1492301166-10292-1-git-send-email-nisalmenuka23@gmail.com>
 <20170416080446.GI17774@n2100.armlinux.org.uk>
 <20170418155725.GG27592@e104818-lin.cambridge.arm.com>
Message-ID: <e7310f9f-96a3-186a-7e5d-7da902bc76f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/17 16:57, Catalin Marinas wrote:
> On Sun, Apr 16, 2017 at 09:04:46AM +0100, Russell King - ARM Linux wrote:
>> On Sat, Apr 15, 2017 at 07:06:06PM -0500, Nisal Menuka wrote:
>>> According to ARM, these errata exist only in a version of Cortex-A8
>>> (r2p0) which was never built. Therefore, I believe there are no platforms
>>> where this workaround should be enabled.
>>> link :http://infocenter.arm.com/help/index.jsp?topic=
>>> /com.arm.doc.faqs/ka15634.html
>>
>> These were submitted by ARM Ltd back in 2009 - if the silicon was never
>> built, there would've been no reason to submit them.  Maybe Catalin can
>> shed some light on this, being the commit author who introduced these?
> 
> We normally try not to submit errata workarounds for revisions that are
> not going to be built/deployed. It's possible that at the time there
> were plans for r2p0 to be licensed and built (not just FPGA) but I don't
> really remember the details. The A8 errata document indeed states that
> r1p0 and r2p0 are obsolete but this can mean many things (like not
> available to license).
> 
> I'll try to see if any of the A8 past product managers know anything
> about this. In the meantime, I would leave them in (no run-time
> overhead).

FWIW, I just fired up a RealView PB-A8 board to check, and that reports
r1p1. True, it's not strictly a real silicon implementation (I think
it's one of the structured ASIC test chips), but since it was, as far as
I'm aware, a commercially-available development system, it's not
impossible that someone may still own and use one of these beasts.

Robin.

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Jan 2018 12:10:26 +0000
Subject: [PATCH v3] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
In-Reply-To: <20180109212212.GD21040@codeaurora.org>
References: <20171213221937.28065-1-sboyd@codeaurora.org>
 <20171214151858.GH4527@arm.com>
 <20180109212212.GD21040@codeaurora.org>
Message-ID: <20180113121026.4gywnkjlxy5wjaga@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 01:22:12PM -0800, Stephen Boyd wrote:
> On 12/14, Will Deacon wrote:
> > On Wed, Dec 13, 2017 at 02:19:37PM -0800, Stephen Boyd wrote:
> > > The Kryo CPUs are also affected by the Falkor 1003 errata, so
> > > we need to do the same workaround on Kryo CPUs. The MIDR is
> > > slightly more complicated here, where the PART number is not
> > > always the same when looking at all the bits from 15 to 4. Drop
> > > the lower 8 bits and just look at the top 4 to see if it's '2'
> > > and then consider those as Kryo CPUs. This covers all the
> > > combinations without having to list them all out.
> > > 
> > > Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > ---
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Thanks for respinning this. Catalin -- can you take this for 4.16, please?
> 
> Can this get picked up? I don't see it in linux-next yet.

I picked it up now but I'll push it tomorrow or Monday (still running
some tests on the unpushed patches).

-- 
Catalin

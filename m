From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 18 Feb 2016 19:28:50 +0100
Subject: [PATCH v4 4/5] arm64/perf: Enable PMCR long cycle counter bit
In-Reply-To: <20160218173428.GE16883@arm.com>
References: <cover.1455810755.git.jglauber@cavium.com>
 <467597048eda3004bd69f1fbe3981aab111e00dd.1455810755.git.jglauber@cavium.com>
 <20160218173428.GE16883@arm.com>
Message-ID: <20160218182850.GC16782@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 05:34:28PM +0000, Will Deacon wrote:
> On Thu, Feb 18, 2016 at 05:50:13PM +0100, Jan Glauber wrote:
> > With the long cycle counter bit (LC) disabled the cycle counter is not
> > working on ThunderX SOC (ThunderX only implements Aarch64).
> > Also, according to documentation LC == 0 is deprecated.
> > 
> > To keep the code simple the patch does not introduce 64 bit wide counter
> > functions. Instead writing the cycle counter always sets the upper
> > 32 bits so overflow interrupts are generated as before.
> > 
> > Original patch from Andrew Pinksi <Andrew.Pinksi@caviumnetworks.com>
> 
> What does this mean? Do we need Andrew's S-o-B, or is this a fresh patch?
> 
> Will

I've modified Andrew's patch. I assumed his formal S-o-B is not
required. Please correct me if I'm wrong.

Jan

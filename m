From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 2 May 2011 15:49:15 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTineKF3Yw+o_PNaq=6btm2MU7TBB+g@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
	<BANLkTinxThB+2+fv4qUD5dyguV-5hUva3A@mail.gmail.com>
	<201104211025.34420.arnd@arndb.de>
	<BANLkTineKF3Yw+o_PNaq=6btm2MU7TBB+g@mail.gmail.com>
Message-ID: <20110502134914.GF740@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Apr 22, 2011 at 09:56:41AM +0200, Linus Walleij wrote:
> 2011/4/21 Arnd Bergmann <arnd@arndb.de>:
> 
> >> Most MFD things are, like I2C chips and stuff but this one sure
> >> match the title "multifunctional device", just that it's very singleton
> >> and very close to the SoC core.
> >
> > One property of MFD devices is that they register a fixed set of
> > child devices (cells) that are each providing separate functionality
> > and have their own drivers. If that's not the case with prcmu,
> > I think it should not be an MFD driver.
> 
> It's both-and. The power domain regulators and cpufreq are
> platform devices and will work nicely as MFD cells spawn
> off the PRCMU. (Just that nooned did it that way before.)
That looks like a potential candidate for drivers/mfd/. I'd have to look at
the code to take it or not, but it's probably worth trying.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

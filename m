From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 25 Aug 2014 10:27:13 -0700
Subject: [PATCH] ARM: bcm: Don't build brcmstb SMP code when building for
 V6
In-Reply-To: <20140822144403.GU24407@sirena.org.uk>
References: <1408673194-16228-1-git-send-email-broonie@kernel.org>
 <20140822050907.GC3246@norris-Latitude-E6410>
 <20140822144403.GU24407@sirena.org.uk>
Message-ID: <20140825172713.GW18411@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 09:44:03AM -0500, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 10:09:07PM -0700, Brian Norris wrote:
> > On Thu, Aug 21, 2014 at 09:06:34PM -0500, Mark Brown wrote:
> > > From: Mark Brown <broonie@linaro.org>
> 
> > > building for -march=armv6 as happens when building allmodconfig. Since I
> > > have not been able to identify a way to override the compiler architecture
> > > selection per file add a Kconfig dependency to ensure this code is not
> > > built if V6 support is enabled.
> 
> > I already proposed this solution to override the compiler architecture,
> > in the same pattern as other similar code in the same directory.
> 
> >   http://article.gmane.org/gmane.linux.drivers.devicetree/84517
> 
> > My using 'CFLAGS_<obj> += <flags>', you can compile in v7.
> 
> I tried that but it wasn't doing the right thing for me - it appeared
> since the compiler ends up getting both -march=armv7-a and -march=armv6
> it complained that it couldn't satisfy both options.  It might be that
> this is version dependant or the actual cause wsa something else, I
> didn't investigate too hard.

If you ever see revisit this or see this again, I'd be interested in
seeing the gcc args (make V=1) and version that failed. My fix worked
for me, and I'll likely use it for the next revision if I don't find a
good reason not to.

Thanks,
Brian

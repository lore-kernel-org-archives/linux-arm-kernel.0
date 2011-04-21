From: davej@redhat.com (Dave Jones)
Date: Thu, 21 Apr 2011 16:14:56 -0400
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110419160545.GJ1765@opensource.wolfsonmicro.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191655.13133.arnd@arndb.de>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
	<201104191801.19348.arnd@arndb.de>
	<20110419160545.GJ1765@opensource.wolfsonmicro.com>
Message-ID: <20110421201455.GA18083@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 05:05:46PM +0100, Mark Brown wrote:
 > On Tue, Apr 19, 2011 at 06:01:19PM +0200, Arnd Bergmann wrote:
 > 
 > > I think it would be good to have the out of the individual
 > > platforms, in particular in order to get better reviews of
 > > new cpufreq drivers by people that are interested in them.
 > 
 > FWIW when I pushed the S3C64x0 cpufreq driver into mainline I posted the
 > driver to the cpufreq list and maintainers but never got any response
 > from them.

Like I said in another mail, the platform-specific nature of cpufreq drivers
means that the only people who can really review them are people familiar
with the architecture. (modulo the cpufreq api bits, but it's usually
either no-brainer stuff, or bugs that aren't immediately obvious from review,
like some of the locking mistakes we've historically seen)

This is why I don't believe that moving this code from arch/ to drivers/
will change anything.

if there's commonality between some of the ARM arch drivers, why can't
there be a arch/arm/cpufreq/ dir for the shared code, and do everything there ?

Right now "move it out of the arm tree into the cpufreq tree" just seems
like a cop-out to hide the problem.

	Dave

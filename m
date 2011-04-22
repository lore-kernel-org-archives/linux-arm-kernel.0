From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Apr 2011 20:40:27 +0100
Subject: Common clock and dvfs
In-Reply-To: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
Message-ID: <20110422194027.GB4768@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 11:15:34AM -0700, Colin Cross wrote:

> Now that we are approaching a common clock management implementation,
> I was thinking it might be the right place to put a common dvfs
> implementation as well.

I looked at this a bit when doing the S3C64xx stuff.

> frequency changes the clock first, and then calls dvfs_set_rate.  For
> a generic implementation, an SoC would provide the clock/dvfs
> framework with a list of clocks, the voltages required for each
> frequency step on the clock, and the regulator name to change.  The
> frequency/voltage tables are similar to OPP, except that OPP gets
> voltages for a device instead of a clock.  In a few odd cases (Tegra

This sounds like it assumes a 1:1 mapping between clocks and supplies
which is going to break at some point.  It should be handlable but will
add complexity.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 11:28:40 +0100
Subject: [PATCH] ASoc: kirkwood: Extend the min and max number of bytes
 per period
In-Reply-To: <20130926102408.GE19304@sirena.org.uk>
References: <20130919112043.5ad16147@armhf>
 <20130926102408.GE19304@sirena.org.uk>
Message-ID: <20130926102840.GP12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 11:24:08AM +0100, Mark Brown wrote:
> On Thu, Sep 19, 2013 at 11:20:43AM +0200, Jean-Francois Moine wrote:
> > This patch extends the min and max number of bytes per period.
> > It mainly permits to reduce the sound delay in MIDI real-time playing.
> 
> Applied, thanks.  For the minimum limit is there any hardware imposed
> limit that could be used rather than tweaking the numbers?

I looked at that, and apart from interrupt rate, I don't see any.

The values I have for these in my tree are:

#define KIRKWOOD_SND_MIN_PERIODS                2
#define KIRKWOOD_SND_MAX_PERIODS                16
#define KIRKWOOD_SND_MIN_PERIOD_BYTES           256
#define KIRKWOOD_SND_MAX_PERIOD_BYTES           0x100000
#define KIRKWOOD_SND_MAX_BUFFER_BYTES           0x100000

which are partly based on patches applied to Rabeeh's kernel, and then
further adjusted.  Yes, the max period bytes won't be reachable since
the minimum period will cause it to be half the max buffer bytes.

From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Sep 2013 15:42:26 +0100
Subject: [PATCH] ASoc: kirkwood: Extend the min and max number of bytes
 per period
In-Reply-To: <20130926102840.GP12758@n2100.arm.linux.org.uk>
References: <20130919112043.5ad16147@armhf>
 <20130926102408.GE19304@sirena.org.uk>
 <20130926102840.GP12758@n2100.arm.linux.org.uk>
Message-ID: <20130927144226.GJ19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 11:28:40AM +0100, Russell King - ARM Linux wrote:

> The values I have for these in my tree are:

> #define KIRKWOOD_SND_MIN_PERIODS                2
> #define KIRKWOOD_SND_MAX_PERIODS                16
> #define KIRKWOOD_SND_MIN_PERIOD_BYTES           256
> #define KIRKWOOD_SND_MAX_PERIOD_BYTES           0x100000
> #define KIRKWOOD_SND_MAX_BUFFER_BYTES           0x100000

> which are partly based on patches applied to Rabeeh's kernel, and then
> further adjusted.  Yes, the max period bytes won't be reachable since
> the minimum period will cause it to be half the max buffer bytes.

Those don't look implausible, obviously it'd be pretty CPU intensive
application that pushed down to the minima but perhaps someone is
willing to pay the cost.  As you say the maximum buffer might want
tweaking (or perhaps the maximum period bytes).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/77bc6353/attachment.sig>

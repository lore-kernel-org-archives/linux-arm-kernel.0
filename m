From: ladis@linux-mips.org (Ladislav Michl)
Date: Wed, 4 Jul 2018 21:45:56 +0200
Subject: droid 4: connection refused from voltage_now
In-Reply-To: <20180704171156.GA3158@amd>
References: <20180704171156.GA3158@amd>
Message-ID: <20180704194556.GA9189@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 07:11:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> I started to use droid 4 as my primary phone... so I have battery
> monitor running for hours... Once every few days it dies with
> "connection refused" error reading battery's "voltage_now". I restart
> it and it continues working...

Ha! What exactly that "connection refused" means? Is it ECONNREFUSED (111)?
I have custom at91 based board here with few custom power supply drivers
and it sometimes ends with voltage_now of my driver being unreadable.
(I modified userspace code and waiting what's in errno in case reading fails)

> That was with v4.17; in v4.18, I'm getting "red screen" a lot.

Tests are also done v4.17.
Adding linux-pm at vger.kernel.org as it seems to be subsytem, specific.

	ladis

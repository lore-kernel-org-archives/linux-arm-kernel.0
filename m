From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Jul 2012 15:44:50 +0100
Subject: Device tree binding for DVFS table
In-Reply-To: <4FFD87BD.2030206@gmail.com>
References: <4FFD77FE.8050206@nvidia.com>
 <4FFD87BD.2030206@gmail.com>
Message-ID: <20120711144449.GA23654@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:

> I'd expect a single property with freq/volt pairs or 2 properties for
> freq and voltage where there is a 1:1 relationship (freq N uses voltage N).

I strongly agree - the current proposal is very hard to read due to the
separation between the voltage and frequency values.  Some devices do
also need to scale multiple rails together, especially when this gets
used for I/O devices.

I'd also expect to see a range of voltages for each frequency rather
than a specific voltage; usually things are at least characterised with
a specified tolerance.

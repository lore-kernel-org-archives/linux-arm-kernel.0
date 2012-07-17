From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 14:03:43 +0000
Subject: [PATCH 0/3 V2] Initial PXA DT bindings
In-Reply-To: <500568F0.8000202@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
 <500568F0.8000202@gmail.com>
Message-ID: <201207171403.43689.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Daniel Mack wrote:
> I wonder what happend to this patch series. I can't seem to find the
> patches in mainline, although it's more than 8 months ago when they were
> discussed. And I can't see any reason for rejecting them in the thread
> either.

I agree. The patches look like they were on the right track and then
just dropped. If you have a vpac270 board, it would be nice if you
could get them running on a newer kernel and submit them again.
Of course if Marek is interested in picking up where he left, that
would also be appreciated.

> I'd like to extend the support to PXA3xx chips and get rid of some board
> files in favour of DT. One uncertainty I have about that is clock
> handling. What's a good migration path to get those bits moved over?
> From what I can see, when probed solely from the device tree, device
> names default to their base address, and the dev_id is a globally
> incrementing counter. Are platforms supposed to provide clock aliases in
> that form?

There are three possible ways to handle that:

1. For the most basic conversion, use an auxdata table to restore the
original names of all devices and don't touch the clock lookup table.

2. For a platform that has all (or most) boards converted to DT, try
not to use an auxdata table and use the names from the device tree
in the clock lookup table.

3. For new platforms and those that want to be up to the latest standards,
use the common clock framework and put the clock lookup into the device
tree using the new clock bindings.

For an incremental conversion, starting with the first option is usually
the easiest.

	Arnd

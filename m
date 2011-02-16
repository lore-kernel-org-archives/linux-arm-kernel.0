From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Feb 2011 18:19:26 -0800
Subject: platform data and mfd design question
In-Reply-To: <4D5AF554.2030208@codeaurora.org>
References: <4D5AF554.2030208@codeaurora.org>
Message-ID: <20110216021925.GC3021@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 01:51:16PM -0800, Abhijeet Dharmapurikar wrote:

> This code can be found here (sorry for the long url - it is convinient to
> click on it),

I can't actually render this URL on a single line without fiddling with
the font size for my terminal...  When pasting gitweb URLs you almost
always want to edit out the head ID and just rely on the branch.

> This gives one the convenience of changing the mfd_cells and their
> platform data in the board file itself. There are boards where the
> platform data of some cells changes and in some cases we dont even
> add a particular cell.

My main question is why you're trying to do this.  Even if some features
aren't used on a given board one would strongly expect that the silicon
will be the same anyway - what's the goal in changing the devices?

> This design makes the core driver very light weight. All it does is
> calls mfd_add_devices on the cell array passed from its platform
> data.

The downside is that it then becomes impossible for the MFD to pass in
resources to the devices (IRQs being the most obvious example) and every
single board needs to replicate the definitions of all the subdevices
which gets tedious, especially if you want to change them for some
reason (eg, an IP becomes used in a wider range of chips so a rename is
appropriate).

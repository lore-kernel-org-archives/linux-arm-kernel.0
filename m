From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jan 2013 11:28:18 -0700
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <51053F81.6020904@gmail.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
Message-ID: <20130128182818.GC9436@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 03:53:53PM +0100, Sebastian Hesselbarth wrote:

> I just want Simon to confirm that Kirkwood's gbe is really loosing the
> contents of its MAC address registers during gated clocks, which is from
> a HW point of view very unlikely.

FWIW, there are two block power management controls on the kirkwood
chips, one is documented to a clock gate, and one is documented to a
be a power down. I wouldn't expect the clock gate to have a problem
with the MAC address, but the powerdown I would expect to wipe it..

Other varients might have only the powerdown..

That said, I'm not sure what Linux uses on Kirkwood, it ideally should
be using both, I think.

Jason

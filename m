From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 1 Feb 2011 21:16:23 -0700
Subject: [PATCH v2 2/6] arm/dt: Allow CONFIG_OF on ARM
In-Reply-To: <20110201103830.19083l8sqoyibqf4@v1539.ncsrv.de>
References: <20110131203626.15105.64302.stgit@localhost6.localdomain6>
	<20110131210400.15105.70374.stgit@localhost6.localdomain6>
	<20110201103830.19083l8sqoyibqf4@v1539.ncsrv.de>
Message-ID: <20110202041623.GE29148@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 10:38:30AM +0100, Hendrik Sattler wrote:
> Zitat von "Grant Likely" <grant.likely@secretlab.ca>:
> >+config USE_OF
> >+	bool "Flattened Device Tree support"
> >+	select OF
> >+	select OF_EARLY_FLATTREE
> >+	help
> >+	  Include support for flattened device tree machine descriptions.
> >+
> 
> Arm doesn't have something called OpenFirmware, still new config
> entries that refer to that name are added. Why no keep _one_ name
> for what you add? I find the random mix of "OF" and "Device Tree"
> rather confusing.

*some* arm platforms have OpenFirmware.  The new OLPC for one.  :-)

But you're right, the OF naming convention is horrid and everyone
hates it, even the OpenFirmware users.  Michael Ellerman has been
working on renaming all the OF* references to DT* or DEVTREE*.

However, until that point, all of the device tree config options are
still named CONFIG_OF*, and I want to maintain commonality until
everything can be renamed all at once.

g.

From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 25 Jun 2011 19:48:19 +0200
Subject: [PATCH 1/4] davinci: psc.h: clean up indentation done using spaces
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F3E@dbde02.ent.ti.com>
References: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F3E@dbde02.ent.ti.com>
Message-ID: <201106251948.19834.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 June 2011, Nori, Sekhar wrote:
> This series of 4 patches added SATA support on DaVinci
> DA850 platform. This was ready for last merge window,
> but was not queued because of the negative diffstat
> rule.
> 
> Is there a possibility of queuing this for the v3.1 merge?
> 
> Here is the archive link of this posting:
> 
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-March/022473.html

My general idea is to have multiple branches per subarchitecture,
and I started merging stuff into the tree now.

Your series contains both cleanups and support for additional
features, and I'd like to see those split into separate branches.

Please make sure the patches apply on top of 2.6.39 and resubmit
them, separating out the first cleanup patch from the others.

We can definitely forward all cleanups and bug fixes in the each
merge window. For new features, it mostly depends on how much
code gets added that should not really be needed in a perfect
world, relative to the amount of cleanups that is actually
going into the platform in order to get there.

In case of the SATA support, the feature is relatively small
and requires little board-specific code, which is good.
However, if you are planning to push a lot of small additions
like this, I would expect you spend much more effort on
consolidation within davinci and migration towards device
tree probing first.

What else do you have pending for davinci in 3.1? Can you
send pull requests for cleanups/fixes/device-tree/features?

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Mar 2014 02:28:19 +0100
Subject: [GIT PULL v3] Xilinx Zynq changes for v3.15
In-Reply-To: <532712D2.4020004@monstr.eu>
References: <53061EBA.1080002@monstr.eu>
 <20140317044453.GA18210@quad.lixom.net> <532712D2.4020004@monstr.eu>
Message-ID: <201403270228.19976.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014, Michal Simek wrote:
> please pull these changes to your arm-soc tree. This branch is based
> on zynq/dt branch.
> Based on my discussion with Olof I have removed zynq-ocm driver
> from this pull request and we will investigate different solution
> 
> Changes in v3: Remove OCM driver from pull request
> Changes in v2: Fix incorrect git repo url

I have pulled it into the next/cleanup2 branch now, sorry for the
delay. Unfortunately I noticed one more thing I didn't like and
did not pull the final patch of the branch, but only the other patches.

The problem I noticed is the soc-bus support: I noticed that you
are populating the entire device tree under the soc node, including
any top-level devices, and that the "xlnx,zynq-devcfg-1.00.a"
node is part of that.

I think what you should try instead is to have only the
amba bus and its children as part of the soc-bus, but other
top-level devices (e.g. board clocks) outside of the soc
node. Also, it would make sense to merge the devcfg stuff
with the amba node, since it's really what makes up the
soc. Does that make sense to you, or do you have reason to
believe it won't work?

	Arnd

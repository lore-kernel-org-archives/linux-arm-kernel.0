From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 19:05:46 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq core - smp for v3.10
In-Reply-To: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
References: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
Message-ID: <201304081905.46201.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013, Michal Simek wrote:
> Hi Arnd and Olof,
> 
> please pull the following smp support to your arm-soc tree.
> 
> This branch is based on zynq/clksrc/cleanup parts because
> there are some dependencies on moving timer to generic location.
> 
> I could based it on standard Linux tagged version but you will get
> several conflicts you will have to resolve.
> If you are OK to resolving these problems, please let me know
> I will create another branch with core-smp changes which are not based
> on zynq/clksrc/cleanup branch.
> 

This one gave me a little trouble because of conflicts with Catalin's
gic/cleanup branch. Could both of you (Michal and Catalin) have a look
at my resolution? I basically just removed the zynq_secondary_init()
function added in this branch.

I've merged it all into next/soc2 and added a merge with gic/cleanup
to resolve the conflict.

Also, please use signed tags for sending pull requests and include
a description of the branch contents that will end up in the merge
commit.

	Arnd

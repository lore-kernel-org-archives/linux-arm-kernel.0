From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 15:00:53 +0000
Subject: [PATCH v2 5/6] xenvm: add a simple PSCI node and a second cpu
In-Reply-To: <1364308875-26484-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <1364308875-26484-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <201303261500.53490.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: rob.herring at calxeda.com
> CC: will.deacon at arm.com
> CC: marc.zyngier at arm.com
> CC: arnd at arndb.de

I wonder how this is supposed to work on real systems. Shouldn't the dt
blob be filled out with the correct number of CPUs at the time you start
the guest? This change looks like you just make all guests use a hardcoded
set of two CPUs instead of just one, but you probably want to allow any
number between 1 and the number of physically present cores.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 22:33:04 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
In-Reply-To: <20150528201817.GZ8557@lukather>
References: <20150511193527.GA29690@lukather> <3861516.4tCLtN1MBu@wuerfel>
 <20150528201817.GZ8557@lukather>
Message-ID: <3504312.mqN5LCp7Sb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 May 2015 22:18:17 Maxime Ripard wrote:
> 
> > A related question is whether we want to pass arguments here, and how
> > to link the controller to the sram nodes.
> 
> Do we need to?
> 
> When a client would try to claim an SRAM, we can parse the phandle,
> find the SRAM name, and look into its own table for the matching name.
> 
> And since it's pretty much how pinctrl (can) work, we can extend that
> mechanism in the future if we want to support other drivers with teh
> same bindings.

The only reason for passing an argument would be the mux ID of the user,
in particular for SRAM_C2, which has three possible users other
than CPU. Passing these as an argument would avoid having to put
the configuration into the inter-driver interface.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2011 17:35:55 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110826130644.GN2308@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108261258.32880.arnd@arndb.de>
	<20110826130644.GN2308@yookeroo.fritz.box>
Message-ID: <201108261735.55412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2011, David Gibson wrote:
> If you open code it this way then yes, it's silly.  But what about
> something like this:
> 
> static struct of_device_id foodevice_of_match[] __devinitdata = {
>         { .compatible = "foocorp,foodevice1234",
>           .resource_names = {"base_regs", "extra_regs", }, },
>         { .compatible = "foocorp,foodevice1239",
>           .resource_names = {"base_regs", "extra_regs", "more_regs", }, }, 
>         { },
> };

Hmm, I hadn't thought of that. This looks quite nice indeed. No objections
to this from my side.

	Arnd

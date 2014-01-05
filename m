From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 5 Jan 2014 20:17:10 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <20140105154023.GA2048@lunn.ch>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
Message-ID: <201401052017.10982.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 January 2014, Andrew Lunn wrote:
> That would be rather odd. These nodes are in the top level SoC dtsi
> file. When they are not used, they have status = "disabled" and are in
> the dtb blob with this state.
> 
> The only reason i can think of them not being present at all is if
> somebody adds an optimizer to dtc which removed disabled nodes. What
> does the device tree spec say about that? Are we relying on undefined
> dtc behavior?

There is no requirement to use the include files. If someone decides
to ship a default dtb file in their boot loader, it wouldn't be
a bug to leave the nodes out entirely.

	Arn

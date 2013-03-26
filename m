From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 11:05:21 +0000
Subject: [GIT PULL] at91: fixes for 3.9-rc #2
In-Reply-To: <51517EEB.7030709@atmel.com>
References: <51517592.5010300@atmel.com> <201303261022.39882.arnd@arndb.de>
 <51517EEB.7030709@atmel.com>
Message-ID: <201303261105.22173.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Nicolas Ferre wrote:
> Indeed, at first sight its looks like a nice solution. But I wonder if
> we add several nodes in this kind of .dtsi files, we may end up with
> mess between APB peripherals and board specific ones like leds, NAND, etc.
> Moreover, the plain and full naming of the node makes it identifiable
> without doubts, even someone not completely familiar with DT.
> 
> I slightly prefer to keep it like this, but I can still change my mind ;-)

If you don't want to use the labels, it's probably better to drop from
the dtsi files. I think you can also write 

ahb/apb/ethernet at 802c000 {
	phy-mode = "rmii";
        status = "okay";
};

although I think most people prefer the labels, and I have not tried
the above.

Back to the bug fix, I think we can have a simpler version for 3.9
if you just mark the ethernet node as "disabled" in the 
at91sam9g15.dtsi file, and then do the patch to change the default
in an add-on patch for 3.10.

	Arnd

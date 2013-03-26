From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 10:22:39 +0000
Subject: [GIT PULL] at91: fixes for 3.9-rc #2
In-Reply-To: <51517592.5010300@atmel.com>
References: <51517592.5010300@atmel.com>
Message-ID: <201303261022.39882.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Nicolas Ferre wrote:
> Another "fixes" pull-request for AT91 on top of material that you have already
> taken. Fixes are manly typos but the bad node declaration and some misspelling
> can cause confusion.

Hi Nicolas,

I'd prefer to take only fixes for serious bugs into 3.9 now, since I have
already sent the fixes for -rc5. As far as I can tell, the macb node patch
is the only one that falls into that category, but for that one, I'd
prefer if it could be redone in a simpler way, by replacing

+       ahb {
+               apb {
+                       macb0: ethernet at f802c000 {
+                               phy-mode = "rmii";
+                               status = "okay";
+                       };
+               };
+       };


with

	@macb0 {
		phy-mode = "rmii";
		status = "okay";
	}

as there is no need to provide the full path when you already have
a label for the device.

	Arnd

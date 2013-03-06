From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Mar 2013 17:01:07 -0800
Subject: [PATCH 3/9] mfd: remove __exit_p annotation for
 twl4030_madc_remove
In-Reply-To: <1362521809-22989-4-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-4-git-send-email-arnd@arndb.de>
Message-ID: <20130306010107.GI11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130305 14:23]:
> 4740f73fe5 "mfd: remove use of __devexit" removed the __devexit annotation
> on the twl4030_madc_remove function, but left an __exit_p() present on the
> pointer to this function. Using __exit_p was as wrong with the devexit in
> place as it is now, but now we get a gcc warning about an unused function.
> 
> In order for the twl4030_madc_remove to work correctly in built-in code, we
> have to remove the __exit_p.

Acked-by: Tony Lindgren <tony@atomide.com>

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Oct 2014 21:50:05 +0100
Subject: [PATCH 1/2] ARM: at91: rm9200 add system timer resources to
 watchdog
In-Reply-To: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <3170633.12AsIiHlY5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 October 2014 21:45:58 Alexandre Belloni wrote:
> To be able to make the watchdog driver independent from the mach/ includes, pass
> the system timer register space as a resource.
> 
> Also, change the name to avoid conflicting with the at91sam9 watchdog driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 

Doing this change as a separate patch breaks bisection because now the device
name no longer matches untile the other patch is applied too.

	Arnd

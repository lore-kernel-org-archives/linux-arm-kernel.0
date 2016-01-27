From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 27 Jan 2016 23:56:22 +0100
Subject: [PATCH] power: APM_EMULATION does not depend on PM
In-Reply-To: <1453736913-1959469-1-git-send-email-arnd@arndb.de>
References: <1453736913-1959469-1-git-send-email-arnd@arndb.de>
Message-ID: <8245283.jd8eAvEnqE@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 25, 2016 04:48:28 PM Arnd Bergmann wrote:
> The APM emulation code does multiple things, and some of them depend on
> PM_SLEEP, while the battery management does not. However, selecting
> the symbol like SHARPSL_PM does causes a Kconfig warning:
> 
> warning: (SHARPSL_PM && PMAC_APM_EMU) selects APM_EMULATION which has unmet direct dependencies (PM && SYS_SUPPORTS_APM_EMULATION)
> 
> From all I can tell, this is completely harmless, and we can simply allow
> APM_EMULATION to be enabled here, even if PM is not.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Rafael

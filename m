From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 30 Jan 2016 17:16:34 +0100
Subject: [PATCH] power: collie_battery: hide unused variable
In-Reply-To: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
References: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Message-ID: <20160130161634.GA5230@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-01-25 16:45:49, Arnd Bergmann wrote:
> The 'wakeup_enabled' variable in this driver is only accessed
> by the optional power management functions and we get a warning
> when they are disabled:
> 
> drivers/power/collie_battery.c:29:12: error: 'wakeup_enabled' defined but not used [-Werror=unused-variable]
> 
> This moves the definition next to the users inside the same #ifdef,
> which avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

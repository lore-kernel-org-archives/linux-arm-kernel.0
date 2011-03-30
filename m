From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 13:38:56 +0200
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <9E9CA0E03AAF4C9AA18DDD7CDE5168A8@subhasishg>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<201103111628.57549.arnd@arndb.de>
	<9E9CA0E03AAF4C9AA18DDD7CDE5168A8@subhasishg>
Message-ID: <201103301338.57207.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2011, Subhasish Ghosh wrote:
> I am using a .setup to initialize pin mux etc. To use the mfd_cells directly 
> should I
> use .enable and .disable of the mfd_cells instead of the .setup.

I think it would be best not to define any per-board functions that
are needed to set up the cell, but rather to initialize it from
the ->probe function of the cell specific driver.

If you need board specific data such as GPIO lists, you can pass
them in the mfd_cell platform_data.
	
	Arnd

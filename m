From: gregkh@suse.de (Greg KH)
Date: Wed, 23 Feb 2011 10:20:53 -0800
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <86364E209B534BF1ADB2764227483070@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<20110218143500.23b3044b@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.1102181917520.2701@localhost6.localdomain6>
	<201102181951.32631.arnd@arndb.de>
	<9826735BD9DD48A599C595D28C4A05F0@subhasishg>
	<20110222143704.GA978@suse.de>
	<86364E209B534BF1ADB2764227483070@subhasishg>
Message-ID: <20110223182053.GB30517@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 11:00:25AM +0530, Subhasish Ghosh wrote:
> I could not follow the recommendations clearly.
> This is just to clarify.
> 
> Currently, I have the following files for the suart implementation:
> 
> drivers/tty/serial/da8xx_pruss/pruss_suart_api.h
> drivers/tty/serial/da8xx_pruss/pruss_suart_err.h
> drivers/tty/serial/da8xx_pruss/pruss_suart_regs.h
> drivers/tty/serial/da8xx_pruss/pruss_suart_board.h
> drivers/tty/serial/da8xx_pruss/pruss_suart_mcasp.h
> drivers/tty/serial/da8xx_pruss/pruss_suart_utils.h
> 
> drivers/tty/serial/da8xx_pruss/pruss_suart_api.c
> drivers/tty/serial/da8xx_pruss/pruss_suart.c
> drivers/tty/serial/da8xx_pruss/pruss_suart_utils.c
> 
> Of these, I will be removing pruss_suart_err.h as part of the Linux
> error code cleanup.
> But, I need to keep at least  pruss_suart_board.h as a separate
> file, as this defines
> configurations which will be often modified by users, I don't want
> to mix it with other files.

Why would a .h file ever need to be "modified by users"?  That sounds
wrong to me.

> Should I combine rest of the headers into a single file ?

Yes, why would they need to be separate?

> and keep the other three .c files under "drivers/tty/serial/" and
> remove the da8xx_pruss directory altogether.

Yes.

thanks,

greg k-h

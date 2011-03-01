From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 1 Mar 2011 14:07:43 +0000
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <99CE1730AA2F4F2F91AFA71BD75FDC41@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-14-git-send-email-subhasish@mistralsolutions.com>
	<20110211162814.6ff274f1@lxorguk.ukuu.org.uk>
	<A6D1CF0E941748448610BE8874FC586F@subhasishg>
	<20110222111103.5d0dd0a7@lxorguk.ukuu.org.uk>
	<99CE1730AA2F4F2F91AFA71BD75FDC41@subhasishg>
Message-ID: <20110301140743.0b9cf140@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I tried using a tasklet for the TX part, but that did not help.
> Another way is to prepare the buffer for the next read and read the data 
> immediately.
> Something like this:
> 
> 1. Call tty_prepare_flip_string while startup.
> 2. When the read interrupt arrives, read the data immediately.
> 3. Call tty_prepare_flip_string for the next read.

Only you then don't know the size of space required/

> Again, the problem here is that we need to use global variables to store the 
> pre-allocated buffers

You don't. You can store them per port in the existing objects !

> The best way is if we can keep the current implementation, one extra copy is 
> not hurting us
> as we do it after the read_data API.

No problem with that at all.

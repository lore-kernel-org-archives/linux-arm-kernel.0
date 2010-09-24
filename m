From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 24 Sep 2010 15:14:07 +0200
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <20100923213654.0c64b047@lxorguk.ukuu.org.uk>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<20100923213654.0c64b047@lxorguk.ukuu.org.uk>
Message-ID: <20100924131407.GA3113@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 09:36:54PM +0100, Alan Cox wrote:
> Drop the clockid_t and swap it for a file handle like a proper Unix or
> Linux interface. The rest is much the same
> 
> 	fd = open /sys/class/timesource/[whatever]
> 
> 	various queries you may want to do to check the name etc
> 
> 	fclock_adjtime(fd, ...)

Okay, but lets extend the story:

	clock_getttime(fd, ...);

	clock_settime(fd, ...);

	timer_create(fd, ...);

Can you agree to that as well?

(We would need to ensure that 'fd' avoids the range 0 to MAX_CLOCKS).

Richard

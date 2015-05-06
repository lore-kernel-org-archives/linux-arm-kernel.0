From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 12:24:50 +0100
Subject: [PATCH  0/2] gpio: Allow userspace export from DT
In-Reply-To: <20150504084925.GB4047@localhost>
References: <20150413110515.9681.58848.stgit@localhost>
 <20150504084925.GB4047@localhost>
Message-ID: <20150506112449.GQ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 10:49:25AM +0200, Johan Hovold wrote:
> Firmware should describe pin directionality and function, and undefined
> pins should never be allowed to be accessed from userspace.

No, that's totally wrong if you consider one of the most common use
cases out there...

Think about something like a Raspberry Pi, where you have a header with
GPIOs on it, which can be used for multiple different purposes (and are
even multiplexed with some on-SoC functions.)

"Firmware" can't know about all possible configurations of those IO pins.

That's why Raspberry Pi uses a userspace helper and programs stuff up
appropriately for the users application.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

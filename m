From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jun 2013 19:09:12 +0100
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130611182927.GP3439@mudshark.cambridge.arm.com>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
 <51B767A8.7000506@wwwdotorg.org>
 <20130611182927.GP3439@mudshark.cambridge.arm.com>
Message-ID: <20130612180912.GW18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 07:29:27PM +0100, Will Deacon wrote:
> Yes. Usually this is a path of no return, but if we detect an error before
> we've changed stack then I think we should at least try to propogate the
> error.

Except, if you make soft_restart able to return an error, then you really
need machine_restart() to do the same, but that's a cross-arch function.

And what do you do when you hit a soft-watchdog event and it calls
machine_restart(), which then decides to fail?  Or a panic event and
machine_restart() fails?

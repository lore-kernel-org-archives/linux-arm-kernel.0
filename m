From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 00:20:57 +0100
Subject: Thread pointer changes
In-Reply-To: <53ADC5B1.6080905@amacapital.net>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
Message-ID: <20140627232056.GZ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right, I'm done on this thread for the weekend - I will not be answering
another message on this subject until next week.  In summary:

I've shown that this isn't as big a problem as first thought, because
there's ways that a libc can trivially detect the CPU that it is running
on, and from that know what instructions are available to it.

I've indicated that the kuser helpers are always provided when there
is no hardware TLS support, which corresponds with a minimum ARM
architecture of version 6K, and v6k has the atomic instructions.

I've said that we're not going to move kuser helpers to a randomised
address, and given strong reasons why not.

I've indicated where the CPU architecture can be retrieved from, and
used to determine the availability of other instructions.

I've indicated that the ELF HWCAPs can be used to further refine the
available instruction information.

That should be sufficient to answer all the questions raised.  Please
wait until next week before asking further questions, thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2016 00:36:40 +0100
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <20160404232926.GV28102@jcartwri.amer.corp.natinst.com>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
 <20160404232926.GV28102@jcartwri.amer.corp.natinst.com>
Message-ID: <20160404233640.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 06:29:26PM -0500, Josh Cartwright wrote:
> Similarly, we're waiting on feedback for:
> 
>   http://lkml.kernel.org/r/1456761716-10174-1-git-send-email-brad.mouring at ni.com
> 
> Also in the queue; also w/ Rob's Ack.  There was a change awhile back to
> unconditionally enable the power-management features of the PL310 which
> caused a noticeable performance degradation on our boards; placing the
> PM options behind a togglable DT property provides us an out.

For that one, I've been wondering why it's seemingly acceptable to
start throwing *errors* for *new* DT properties which weren't required
before.  Also, there's no DT documentation for the new properties,
which is a fundamental requirement - and Rob should not have given
his ack without there being a DT documentation patch.

Obviously, the kernel review process has broken on this one... or
I must remember this sneaky trick for getting new DT properties in
without the required documentation...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Jun 2015 11:03:51 +0100
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <20150506114417.GI30910@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel> <20150506114417.GI30910@pali>
Message-ID: <20150625100351.GB7576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 01:44:17PM +0200, Pali Roh?r wrote:
> On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> > What I mean is which code accesses this variable that early?
> > 
> 
> ATAG code is doing it at same early stage, so I added it to same early
> stage...

ATAG code does it early because ATAGs are only available early on, and
it's simpler to parse them all in one go, rather than having to do
multiple passes over the structure - especially when most instances are
just storing an integer to some BSS variable.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

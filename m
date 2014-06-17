From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jun 2014 11:23:44 +0100
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617102123.GA13808@arm.com>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
 <20140617101606.GE23430@n2100.arm.linux.org.uk>
 <20140617102123.GA13808@arm.com>
Message-ID: <20140617102344.GG23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 11:21:23AM +0100, Will Deacon wrote:
> I think that actually works ok, because writing zeroes doesn't actually
> do anything as far as I understand. The problem with suspend/resume is
> that the suspend/resume cycle could well clear the internal state and
> writing zeroes won't re-enable the workaround bits.
> 
> I'll double-check this with the hardware guys, since this register really
> is undocumented.

Are you saying that it is write one to set, and writing zero is ignored?
If that's true, we should simplify the work-around code to get rid of the
read-modify-write.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Feb 2015 23:01:37 +0000
Subject: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <CANqRtoQsKVNMWrj1LZdinHs_iZmsCwWxtqmMWv7SENS3-QXk1A@mail.gmail.com>
References: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
 <20150213202002.GB29727@verge.net.au>
 <54DE5D3A.5070104@codeaurora.org>
 <CANqRtoSOBf3ZCKdKYta-P2q==ZMHk=VZgfEztPJ+uaKQtkBWjg@mail.gmail.com>
 <54DE65C6.8000304@codeaurora.org>
 <CANqRtoQsKVNMWrj1LZdinHs_iZmsCwWxtqmMWv7SENS3-QXk1A@mail.gmail.com>
Message-ID: <20150213230137.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 09:44:50PM +0000, Magnus Damm wrote:
> Also, based on the comment in mcpm_cpu_can_disable() it looks like the
> PSCI hook may be executed once only with your change in place?
> Hopefully PSCI is OK not being invoked for every CPU shutdown.

This is why I've said (in the parent thread) that I'm not happy to
apply this patch.  Mark Rutland has indicated that he has MCPM cases
where the CPUs which can be disabled changes dynamically according
to the secure firmware requirements, and ripping out todays
infrastructure in light of that, only to have to add it back again
later makes no sense.

However, cleaning things up by removing unnecessary cpu_disable
methods is a good thing to do irrespective of that.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

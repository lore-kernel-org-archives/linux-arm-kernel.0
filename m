From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 01:28:59 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <yw1x4mg9posf.fsf@unicorn.mansr.com>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
 <yw1x8u5lpqqz.fsf@unicorn.mansr.com>
 <alpine.LFD.2.20.1511251931050.22569@knanqh.ubzr>
 <yw1x4mg9posf.fsf@unicorn.mansr.com>
Message-ID: <20151126012859.GX8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 12:50:08AM +0000, M?ns Rullg?rd wrote:
> If not calling the function saves an I-cache miss, the benefit can be
> substantial.  No, I have no proof of this being a problem, but it's
> something that could happen.

That's a simplistic view of modern CPUs.

As I've already said, modern CPUs which have branch prediction, but
they also have speculative instruction fetching and speculative data
prefetching - which the CPUs which have idiv support will have.

With such features, the branch predictor is able to learn that the
branch will be taken, and because of the speculative instruction
fetching, it can bring the cache line in so that it has the
instructions it needs with minimal or, if working correctly,
without stalling the CPU pipeline.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

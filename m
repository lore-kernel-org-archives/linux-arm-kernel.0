From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Jul 2013 10:20:19 -0400 (EDT)
Subject: [PATCH v4 02/17] sched_clock: Use seqcount instead of rolling
 our own
In-Reply-To: <20130719090328.GA18139@mudshark.cambridge.arm.com>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-3-git-send-email-sboyd@codeaurora.org>
 <20130719090328.GA18139@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1307191016010.14924@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Jul 2013, Will Deacon wrote:

> Looks good to me. The current scheme would be very fiddly to extend to
> 64-bit values on 32-bit architectures without cheap atomic doubleword
> accesses.

You should have a look at include/linux/cnt32_to_63.h.
This could be applied to pure software counters if the low part is 
atomically increased.


Nicolas

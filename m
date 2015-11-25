From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 23:47:11 +0000
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151125234711.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 01:51:03PM -0800, Stephen Boyd wrote:
> The ARM compiler inserts calls to __aeabi_uidiv() and
> __aeabi_idiv() when it needs to perform division on signed and
> unsigned integers. If a processor has support for the udiv and
> sdiv division instructions the calls to these support routines
> can be replaced with those instructions. Therefore, record the
> location of calls to these library functions into two sections
> (one for udiv and one for sdiv) similar to how we trace calls to
> mcount. When the kernel boots up it will check to see if the
> processor supports the instructions and then patch the call sites
> with the instruction.

Do we have any resolution on these programs which modify the object
files in-place, rather than breaking any hard-links which may be
present (eg, as a result of using ccache in hard-link mode) ?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

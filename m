From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Feb 2015 13:31:42 +0000
Subject: [RFC PATCH] ARM: LL_DEBUG: Fix hang on i.MX53 when wrong port
 selected.
In-Reply-To: <20150213124849.22919.14204.stgit@localhost>
References: <20150213124849.22919.14204.stgit@localhost>
Message-ID: <20150213133142.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 01:48:49PM +0100, Martin Fuzzey wrote:
> Hence RFC status for the moment to see if there are any better ideas.

How about detecting the condition in the addruart macro - if the UART
is not enabled, we can clear r1 - and detect that in the various users
and just bail out.  We wouldn't need to test on every character then.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

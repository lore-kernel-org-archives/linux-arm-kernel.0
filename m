From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 13:13:49 +0100
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
References: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
Message-ID: <20150519121349.GE2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 11:20:11AM +0000, Sarbojit Ganguly wrote:
> Yes, I will try to do that. OTOH, I saw that  there was a discussion on
> removal of bad_xchg() altogether. Perhaps that approach be better than
> adding this half word exchange?

The only possibility for removal of __bad_xchg() is to remove it's
_definition_ only, not its callsite, so that we get a _link_ time
error for use cases we don't support.

Removing its callsite leaves us open to code malfunction: xchg()
effectively becomes a no-op for sizes which are not supported, and
that's a _very_ bad thing to happen.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

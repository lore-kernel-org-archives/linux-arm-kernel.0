From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2016 11:07:35 +0000
Subject: [PATCH 1/1] mm: call force_sig_info before prints
In-Reply-To: <1482143832-11158-1-git-send-email-maninder1.s@samsung.com>
References: <1482143832-11158-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20161219110735.GR14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 04:07:12PM +0530, Maninder Singh wrote:
> prints can delay queuing of signal, so better to print
> after force_sig_info.
> 
> Let's say process generated SIGSEGV , and some other thread sends
> SIGKILL to crashing process and it gets queued before SIGSEGV becuase
> of little delay due to prints so in this case coredump might not generate.

In any case, that's going to be a race - you can't predict exactly when
the "other thread" will send the SIGKILL in relation to the SIGSEGV.

So, I don't see the point of this change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

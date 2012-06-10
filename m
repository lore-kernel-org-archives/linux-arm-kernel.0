From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 10 Jun 2012 22:33:40 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <20120610201310.GB22507@lunn.ch>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
 <4FD4E2DE.20006@baatz.info> <20120610201310.GB22507@lunn.ch>
Message-ID: <20120610203340.GB26603@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 10:13:10PM +0200, Andrew Lunn wrote:
> On Sun, Jun 10, 2012 at 08:09:34PM +0200, Simon Baatz wrote:
...
> Do you have any other drivers built as modules? I was conservative and
> turned the clock on in the probe function, so i expect that most work
> as modules. However XOR has a similar sort of structure, so might also
> be broken...

I don't use XOR as module. However, in addition to the Ethernet
one, I have the following modules that enable clocks:

mv_cesa
sata_mv 
ehci_hcd

I did not encounter any problem with these so far (with the exception
of data corruption in mv_cesa, which is completely unrelated (and is
no problem of mv_cesa, but a problem of the current implementation of
flush_kernel_dcache_page in my view)).

- Simon

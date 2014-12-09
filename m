From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Dec 2014 10:29:05 +0000
Subject: using DMA-API on ARM
In-Reply-To: <5486CCBC.3@broadcom.com>
References: <5481794E.4050406@broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01902076@SJEXCHMB15.corp.ad.broadcom.com>
 <2863746.4sUSEYqahB@wuerfel>
 <20141208160316.GM16185@e104818-lin.cambridge.arm.com>
 <5485D97D.1040404@broadcom.com> <5486CCBC.3@broadcom.com>
Message-ID: <20141209102904.GJ11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 11:19:40AM +0100, Arend van Spriel wrote:
> The issue did not trigger overnight so it seems setting bit 22 <Shared
> Attribute _Override_ Enable> solves the issue over here. Now the question is
> how to move forward with this. As I understood from Catalin this patch was
> not included as it was not considered responsibility of the linux kernel.

It is preferable for firmware to configure the L2 cache appropriately,
which includes things like the prefetch offsets as well as feature bits
like bit 22.

I think what I'll do is queue up a patch which adds a warning if bit 22
is not set, suggesting that firmware is updated to set this bit.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

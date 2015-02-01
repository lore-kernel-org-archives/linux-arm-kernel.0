From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Feb 2015 08:42:45 +0000
Subject: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
In-Reply-To: <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
 <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
Message-ID: <20150201084245.GF26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 01, 2015 at 02:39:42PM +1100, Finn Thain wrote:
> I find the ARM support in drivers/char/nvram to be surprising, not to say 
> questionable. The /proc/driver/nvram implementation, given 
> defined(__arm__), decodes the NVRAM contents in exactly the same format as 
> when defined(__i386__) || defined(__x86_64__).

That's because it's used on the Netwinder and EBSA285 platforms, which
are PCI-like, complete with a southbridge which makes them look like a
PC.

> Whereas, only MIPS and 
> PowerPC defconfigs set CONFIG_RTC_DRV_CMOS at all, and without that symbol 
> the driver will never be built for ARM. This raises the question, does 
> /proc/driver/nvram do anything useful on any ARM platforms?

Yes.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

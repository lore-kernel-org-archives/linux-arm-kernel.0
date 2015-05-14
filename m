From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 May 2015 17:15:26 +0100
Subject: [PATCH v2] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <1431620035-7183-1-git-send-email-hauke@hauke-m.de>
References: <1431620035-7183-1-git-send-email-hauke@hauke-m.de>
Message-ID: <20150514161526.GB2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 06:13:55PM +0200, Hauke Mehrtens wrote:
> These options make it possible to overwrites the data and instruction
> prefetching behavior of the arm pl310 cache controller.
> 
> We have to set these values in the aux and the prefetch register,
> because these two bits in the aux registers are mapped to the prefetch
> register. If only the prefetch register is changed there is an
> inconsistence in the state in this driver.

No there isn't.  Just set the bits in the prefetch register.

Writing to the prefetch register changes the state of the bits in the
auxiliary control register at the same time.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 19:15:49 +0000
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101219174017.GA31832@alchark-u3s>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
	<20101107171726.GF1759@n2100.arm.linux.org.uk>
	<20101108171930.GA1471@alchark-u3s.lan>
	<20101111212322.GA15533@alchark-u3s.lan>
	<20101111234957.GA28735@n2100.arm.linux.org.uk>
	<20101219174017.GA31832@alchark-u3s>
Message-ID: <20101220191549.GH28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 19, 2010 at 08:40:17PM +0300, Alexey Charkov wrote:
> +config ARCH_VT8500
> +	bool "VIA/WonderMedia 85xx"
> +	select CPU_ARM926T
> +	select GENERIC_GPIO
> +	select ARCH_HAS_CPUFREQ
> +	select GENERIC_TIME

Everything looks good, except for the above.  You don't need to select
GENERIC_TIME - it doesn't exist anymore.

It's also good to see that you've picked up on registering clocksources
with the _hz/_khz functions.

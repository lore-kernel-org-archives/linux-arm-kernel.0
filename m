From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 27 Mar 2011 20:13:19 +0300
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <87r59sbixx.fsf@free.fr>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<1301240089.10831.2.camel@konomi> <87r59sbixx.fsf@free.fr>
Message-ID: <201103272013.19981.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 March 2011 19:56:58 Robert Jarzmik wrote:

> These 2 work well on the mioa701 platform, under the constraint that the
> minimal frequency is set to 208 instead of 104.
> 
> I would think as Marek that it's a under-voltage issue, unless it's the
> 104Mhz transition issue which lasts for as long as I own my platform (and
> which might be mioa701 specific AFAIK).

I tried to disable regulator at all (so, regulator is left in default state), 
stock bootloader configures CPU to 208mhz(normal)/312mhz(fast) and enables 
fast mode, but leaves fastbus disabled. So I tried fixed 208mhz and 312mhz 
with fastbus bit set - it hangs in random places, even without cpu freq 
transitions... So maybe it's some hw misdesign, but once again - it works 
pretty stable @104-416mhz with fastbus disabled.

Regards
Vasily

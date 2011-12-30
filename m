From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 30 Dec 2011 13:00:42 +0100
Subject: [RFC] cpufreq: Add S3C2416/S3C2450 cpufreq driver
In-Reply-To: <20111230082319.GC2414@b20223-02.ap.freescale.net>
References: <201112292058.07448.heiko@sntech.de>
 <20111230082319.GC2414@b20223-02.ap.freescale.net>
Message-ID: <201112301300.43730.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

Am Freitag 30 Dezember 2011, 09:23:21 schrieb Richard Zhao:
> would it be possible to use clk-reg-cpufreq driver I sent out?

I thought about it when your driver was introduced first. It would be possible 
if the frequency scaling would only happen on the armdiv.

But as you probably saw in the code the S3C2416 has two clock sources for the 
armclk (armdiv and hclk) and also special requirements on the switch of those 
(i.e. when switching to armdiv, force the frequency to be the same as the 
hclk, to prevent stability issues).

Therefore I don't think these behaviour requirements can be modelled with your 
clk-reg-cpufreq driver.

Heiko

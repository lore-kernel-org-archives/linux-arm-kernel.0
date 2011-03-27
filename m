From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 27 Mar 2011 10:28:56 +0300
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <201103270152.45581.marek.vasut@gmail.com>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<201103270152.45581.marek.vasut@gmail.com>
Message-ID: <201103271028.56672.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 March 2011 03:52:45 Marek Vasut wrote:
> On Saturday 26 March 2011 20:51:43 Vasily Khoruzhick wrote:
> > PXA27x does not like fastbus for some reason, it can hang in
> > random places when it's enabled. So don't use it to make cpufreq
> > stable.
> 
> This is B/S, you're loosing performance!

I'm losing nothing, without this patch cpufreq does not work stable at all on 
Zipit Z2.

> I'd suggest module parameter or
> device- specific callback to toggle use of fastbus on/off.

Can you test cpufreq without this patch on pxa270-based board with ondemand or 
conservative governor (or userspace with 104/208/312mhz)? Is it stable? If not 
then there's no reason to leave fastbus. Btw, pxa25x table has fastbit unset 
for some reason. Maybe there's some unknown errata about fastbus bit (same as 
half turbo?)

Regards
Vasily

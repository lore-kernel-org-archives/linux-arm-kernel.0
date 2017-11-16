From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 16 Nov 2017 17:51:05 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <nycvar.YSQ.7.76.1711161140030.20817@knanqh.ubzr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
 <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
 <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
 <20171115131351.GE31757@n2100.armlinux.org.uk>
 <1fa81694-7bd2-564b-e5b9-ae53b9ea6620@sigmadesigns.com>
 <20171116153625.GJ31757@n2100.armlinux.org.uk>
 <9a4cfa9d-3940-b7f2-5a4d-59e89af85bb7@sigmadesigns.com>
 <nycvar.YSQ.7.76.1711161106240.20817@knanqh.ubzr>
 <48c38055-20f7-e565-aa56-74f360e6e3d9@sigmadesigns.com>
 <nycvar.YSQ.7.76.1711161140030.20817@knanqh.ubzr>
Message-ID: <870aeb80-bbc5-52ed-cca2-3e762e27bfe2@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/2017 17:47, Nicolas Pitre wrote:

> Look at cpufreq_callback() in arch/arm/kernel/smp.c.

Are you pointing at the scaling of loops_per_jiffy done in that function?

As I wrote earlier:

If I'm reading arch/arm/kernel/smp.c correctly, loops_per_jiffy is scaled
when the frequency changes.

But arch/arm/lib/delay-loop.S starts by loading the current value of
loops_per_jiffy, computes the number of times to loop, and then loops.
If the frequency increases when the core is in __loop_delay, the
delay will be much shorter than requested.

From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 14 Dec 2012 11:37:04 +0100
Subject: ARM realview breakages w/ 3.7 under qemu
In-Reply-To: <20121214094012.GG14363@n2100.arm.linux.org.uk>
References: <50CA0FC1.5090009@openwrt.org>
 <20121213174817.GB12946@mudshark.cambridge.arm.com>
 <20121214094012.GG14363@n2100.arm.linux.org.uk>
Message-ID: <50CB0150.1000901@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/14/12 10:40, Russell King - ARM Linux a ?crit :
> On Thu, Dec 13, 2012 at 05:48:17PM +0000, Will Deacon wrote:
>> On Thu, Dec 13, 2012 at 05:26:25PM +0000, Florian Fainelli wrote:
>>> - PBX A9: booting with less than 1024MBytes of RAM causes this:
>>> [    0.000000] Truncating RAM at 20000000-3fffffff to -3f7fffff (vmalloc
>>> region overlap).
>>> [    0.000000] Ignoring RAM at 80000000-8fffffff (vmalloc region overlap).
>>>
>>> Do these issues sounds familiar to any of you? The kernel config is
>>> attached in case that helps.
> I don't have the original email to reply to (so I don't have the .config
> either) but my guess for the above would be that HIGHMEM is disabled.
The original mail containing the .config file was actually rejected by 
the mailing-list manager. I have uploaded it here: 
http://alphacore.org/~florian/openwrt/realview-eb-config

You are right, HIGHMEM is disabled. Even though enabling HIGHMEM does 
not allow me booting either without at least 1Gbyte of RAM:

[    0.000000] Memory policy: ECC disabled, Data cache writealloc
and we are stuck.
--
Florian

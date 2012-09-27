From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Sep 2012 13:48:56 +0000
Subject: How to get revision and serial numbers with device tree?
In-Reply-To: <5063E1C2.8020407@bluegiga.com>
References: <5063E1C2.8020407@bluegiga.com>
Message-ID: <201209271348.56700.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 September 2012, Lauri Hintsala wrote:
> 
> /proc/cpuinfo contains revision and serial numbers. They are got from 
> ATAGs when device tree is disabled. How are they managed when device 
> tree is in use? On my imx28 based board they are zeros.

Right, we don't currently interpret a serial number from the device tree.
At least IBM uses a "system-id" property in the root node for the serial
number, and we could theoretically show this in /proc/cpuid, but I don't
think any of the ARM systems currently fill this correctly, and it is
a string property, so we can't use it interchangeably with the integer
in the ATAGs.

	Arnd

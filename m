From: bert@biot.com (Bert Vermeulen)
Date: Mon, 4 Apr 2016 13:51:56 +0200
Subject: [PATCH] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
In-Reply-To: <20160402161639.GF32554@lunn.ch>
References: <1459601753-31193-1-git-send-email-bert@biot.com>
 <20160402161639.GF32554@lunn.ch>
Message-ID: <5702555C.1020408@biot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2016 06:16 PM, Andrew Lunn wrote:
> On Sat, Apr 02, 2016 at 02:55:52PM +0200, Bert Vermeulen wrote:
>> + * (c) 2013 Jonas Gorski <jogo@openwrt.org>
>> + * (c) 2013 Deutsche Telekom Innovation Laboratories
>> + * (c) 2014 Luka Perkov <luka@openwrt.org>
>> + * (c) 2014 Randy C. Will <randall.will@gmail.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>
> Could you dual license this under X11 as well? You will need agreement
> from the copyright holders above, if they wrote DT fragments.
 >
 > Not many kirkwood boards are, but we encourage most Marvell SoCs DT
 > files to be dual license.

I did not get responses from all authors, so no dice.

>> +	chosen {
>> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
>
> Please change this to stdout-path = "serial0:115200n8";

I've added a serial alias (the actual label is uart0). That alias and one 
for serial1 might perhaps be better in kirkwood.dts, but I'll leave that up 
to you.

> The 6171 is a 7 port device. Is the last port also a 'cpu' port?

I don't think so. I didn't manage to get anything through it, and I can't 
see the CPU traces on the PCB (neither 5 nor 6).


-- 
Bert Vermeulen
bert at biot.com

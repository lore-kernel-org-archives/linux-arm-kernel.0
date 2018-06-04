From: rah@settrans.net (Bob Ham)
Date: Mon, 4 Jun 2018 18:33:02 +0100
Subject: [PATCH v2] arm: sun4i: Add support for Pengpod 1000 tablet
In-Reply-To: <20180604081302.hcn7j36gt6xeyquq@flea>
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
Message-ID: <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/18 09:13, Maxime Ripard wrote:
> On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:

>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.

>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.

> And this is redundant with the SPDX header.

The X11 license notice states explicitly that the notice has to be
included in the file.  Wouldn't removing it be a violation of the license?


>> +		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
> 
> Each step should increase the perceived brightness by roughly 1/Nth, N
> being the number of steps. Usually PWM backlights don't work like that.

FYI, this was copied from another .dts file.  All of the other
brightness-levels settings in sun{4,5,7}i .dts files follow similar
patterns:

sun4i-a10-dserve-dsrv9703c.dts:               brightness-levels = <0 10
20 30 40 50 60 70 80 90 100>;
sun4i-a10-inet1.dts:          brightness-levels = <0 10 20 30 40 50 60
70 80 90 100>;
sun4i-a10-pov-protab2-ips9.dts:               brightness-levels = <0 10
20 30 40 50 60 70 80 90 100>;
sun5i-a13-empire-electronix-d709.dts:         brightness-levels = <0 10
20 30 40 50 60 70 80 90 100>;
sun5i-a13-utoo-p66.dts:       brightness-levels = <0 30 40 50 60 70 80
90 100>;
sun5i-gr8-evb.dts:            brightness-levels = <0 10 20 30 40 50 60
70 80 90 100>;
sun7i-a20-wexler-tab7200.dts:         brightness-levels = <0 10 20 30 40
50 60 70 80 90 100>;

I'll take the brightness-levels from sun8i-a83t-tbs-a711.dts which
follows a more appropriate pattern:

sun8i-a83t-tbs-a711.dts:              brightness-levels = <0 1 2 4 8 16
32 64 128 255>;


Thanks,

Bob

-- 
Bob Ham <rah@settrans.net>

for (;;) { ++pancakes; }

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 2913 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/b46aec55/attachment.sig>

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 1 Apr 2015 11:18:29 +0200
Subject: [PATCH 0/5] Add standby support for the recent mvebu SoCs
In-Reply-To: <CAPv3WKew5FFsA+ZphXO1hfYcy5hi_SzEBBhyk5QtQ5zn-SAenQ@mail.gmail.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKew5FFsA+ZphXO1hfYcy5hi_SzEBBhyk5QtQ5zn-SAenQ@mail.gmail.com>
Message-ID: <20150401111829.311a73fa@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Wed, 1 Apr 2015 11:02:47 +0200, Marcin Wojtas wrote:

> When I run standby on A385 I get following error:
> root at localhost:~# echo standby > /sys/power/state
> [  122.889266] PM: System core suspend callback
> mvebu_mbus_suspend+0x0/0xf4 failed.
> 
> Did you see this issue in your setup?

You need to change your DT to include an additional set of registers
for the MBus node.

This is something that we probably need to change in the mvebu-mbus
driver, I remember we discussed this with Greg.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

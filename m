From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 5 Aug 2013 12:06:45 +0530
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <51F827EC.3090104@hauke-m.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <51F28A20.7060105@hauke-m.de>
 <20130726165311.GH17886@mudshark.cambridge.arm.com>
 <201307272149.17108.arnd@arndb.de>
 <20130730133601.GN11527@mudshark.cambridge.arm.com>
 <51F827EC.3090104@hauke-m.de>
Message-ID: <51FF47FD.6080401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hauke,

On Wednesday 31 July 2013 02:24 AM, Hauke Mehrtens wrote:

> Now, with 3.11-rc3 it crashed reproducible after Freeing unused kernel
> memory, see this:
>
> [    0.859198] Freeing unused kernel memory: 1124K (c0260000 - c0379000)
> [    0.866298] Unhandled fault: imprecise external abort (0x1c06) at
> 0xb6f8b005
> [    0.873538] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000007
>
> Do you have some more informations about this type of error?

If upon entry to kernel, CPSR.A is '1', change it '0' (enable 
asynchronous abort) and see if it makes the abort more precise.

Regards
Afzal

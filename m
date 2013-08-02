From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 10:55:46 +0100
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <51FAD84A.4070701@hauke-m.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <51F28A20.7060105@hauke-m.de>
 <20130726165311.GH17886@mudshark.cambridge.arm.com>
 <201307272149.17108.arnd@arndb.de>
 <20130730133601.GN11527@mudshark.cambridge.arm.com>
 <51F827EC.3090104@hauke-m.de>
 <20130731103507.GF23681@mudshark.cambridge.arm.com>
 <51FAD84A.4070701@hauke-m.de>
Message-ID: <20130802095546.GJ2465@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 10:51:06PM +0100, Hauke Mehrtens wrote:
> On 07/31/2013 12:35 PM, Will Deacon wrote:
> > Hmm, so that's now exploding on a user address. Is this an A9-based SoC? If
> > so, can you try disabling PL310 (CONFIG_CACHE_L2X0) and see if it makes a
> > different please?
> 
> This is a A9-based SoC.
> 
> I already had PL310 disabled, now I tried to activate it, but I do not
> see any difference.
> 
> [    1.049381] Freeing unused kernel memory: 1128K (c0261000 - c037b000)
> [    1.056501] Unhandled fault: imprecise external abort (0x1c06) at
> 0xb6f34005
> [    1.063738] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00000007

Ok, in which case I think you need to try Arnd's other suggestion of moving
the loop around in order to try and bisect where the fault is being
generated.

Will

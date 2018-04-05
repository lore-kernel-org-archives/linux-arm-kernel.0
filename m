From: rabin@rab.in (Rabin Vincent)
Date: Thu, 5 Apr 2018 22:48:33 +0200
Subject: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
In-Reply-To: <20180405200916.27964-1-drivshin@awxrd.com>
References: <20180405200916.27964-1-drivshin@awxrd.com>
Message-ID: <20180405204833.hn56zpd474jywrm3@lnxartpec.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 04:09:16PM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
> 
> NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly based
> on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM is the number
> of total registers, while GDB_MAX_REGS is the number of 'unsigned longs'
> it takes to serialize those registers. Since FP registers require 3
> 'unsigned longs' each, DBG_MAX_REG_NUM is smaller than GDB_MAX_REGS.
> 
> This causes GDB 8.0 give the following error on connect:
> "Truncated register 19 in remote 'g' packet"
> 
> This also causes the register serialization/deserialization logic to
> overflow gdb_regs[], overwriting whatever follows.
> 
> Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
> Cc: <stable@vger.kernel.org> # 2.6.37+
> Signed-off-by: David Rivshin <drivshin@allworx.com>

Acked-by: Rabin Vincent <rabin@rab.in>

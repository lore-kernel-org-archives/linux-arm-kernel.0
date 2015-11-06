From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 5 Nov 2015 20:14:23 -0500
Subject: [PATCH 1/2] serial: amba-pl011: use cpu_relax when polling
 registers
In-Reply-To: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
Message-ID: <563BFEEF.3020709@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2015 10:01 AM, Timur Tabi wrote:
> Busy loops that poll on a register should call cpu_relax().  On some
> architectures, it can lower CPU power consumption or yield to a
> hyperthreaded twin processor.  It also serves as a compiler barrier,
> so it can replace barrier() calls.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

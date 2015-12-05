From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 12:23:16 -0500
Subject: [PATCH LINUX v3 06/10] tty: xuartps: Keep lock for whole ISR
In-Reply-To: <1448161172-19717-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-7-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56631D84.3010808@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> The RX path in the interrupt handler released a lock unnecessarily.

Yep. Remnant of old low_latency steering.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

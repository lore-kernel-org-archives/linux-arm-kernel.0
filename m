From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 12:21:34 -0500
Subject: [PATCH LINUX v3 05/10] tty: xuartps: Improve startup function
In-Reply-To: <1448161172-19717-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-6-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56631D1E.8050406@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> The startup function is supposed to initialize the UART for receiving.
> Hence, don't enable the TX part. Also, protect HW accesses with the port
> lock.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

NB: the request_irq() should be _after_ h/w programming, otherwise an
interrupt could be triggered and in-progress before the h/w has been
setup.

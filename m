From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sat, 5 Dec 2015 13:47:09 -0800
Subject: [PATCH LINUX v3 05/10] tty: xuartps: Improve startup function
In-Reply-To: <56631D1E.8050406@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-6-git-send-email-soren.brinkmann@xilinx.com>
 <56631D1E.8050406@hurleysoftware.com>
Message-ID: <20151205214709.GM4900@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-12-05 at 12:21PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > The startup function is supposed to initialize the UART for receiving.
> > Hence, don't enable the TX part. Also, protect HW accesses with the port
> > lock.
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> 
> NB: the request_irq() should be _after_ h/w programming, otherwise an
> interrupt could be triggered and in-progress before the h/w has been
> setup.

Thanks for pointing that out. I'll patch that.

	S?ren

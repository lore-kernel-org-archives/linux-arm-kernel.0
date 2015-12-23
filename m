From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 23 Dec 2015 03:49:08 -0800
Subject: [RFC LINUX PATCH] dt: xilinx: xadc: provision to control clock
 frequency
In-Reply-To: <1450866505-22069-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1450866505-22069-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20151223114908.GG6491@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-23 at 03:58PM +0530, Ranjit Waghmode wrote:
> This patch adds parameter to the xilinx-xadc node for controlling
> clock frequency.
> 
> Following are the possible options for user to control the frequency:
> 	* 00 : 1/2 of clock frequency
> 	* 01 : 1/4 of clock frequency
> 	* 10 : 1/8 of clock frequency
> 	* 11 : 1/16 of clock frequency

How is this chosen? Are these just arbitrary values that you need for
some use-case? Or are these the options HW allows?

> 
> So this patch adds parameter tck-rate to set user defined values from
> above pool to control the clock frequency.

This is no longer describing HW, but configuring driver/HW. Why does
this have to be in DT? Why can't the driver request/set the frequency as
operation requires it?

	Thanks,
	S?ren

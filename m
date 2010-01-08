From: mkl0301@hotmail.com (mkl lin)
Date: Fri, 8 Jan 2010 15:09:49 +0000
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <1687fa361001080514g57ff7a33k4521961fe5fdeb64@mail.gmail.com>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>,
	<1687fa361001070250l62628061h4bebaca1c03d2638@mail.gmail.com>,
	<1687fa361001070545q73e6738apd6ce5650316eca26@mail.gmail.com>,
	<20100107143916.GA24990@pengutronix.de>,
	<1687fa361001080514g57ff7a33k4521961fe5fdeb64@mail.gmail.com>
Message-ID: <SNT109-W17F04458915DBA5AA1D665A7700@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Having this patch applied and having mkl lin's test module working
> now, it seems to me that I'm not able to reproduce mkl lin's issues,
> though. I will do some additional tests.

I think my issues is because of my serial driver detected and enabled the workaround for UART_BUG_THRE. I'm not sure whether should it be or not. If I force it not to enable the workaround, the serial driver works just fine, even without the previous patch. You could ensure that whether UART_BUG_THRE is enabled or not. if not, there is nothing to race with.

And if you want to try my test, you should not have it in a script file. I have it all in one command line, and keep repeat <up-arrow><enter><up-arrow><enter>... in a very fast speed, not waiting the last finish printing. The purpose is to have kernel (printk) and user space(sh) keep printing at the same time, so the printk would have race condition with serial8250_backup_timeout.

Best Regards,
Mac Lin
 		 	   		  
_________________________________________________________________
Windows Live: Friends get your Flickr, Yelp, and Digg updates when they e-mail you.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010

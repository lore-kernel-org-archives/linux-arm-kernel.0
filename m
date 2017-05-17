From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 17 May 2017 11:31:40 +0800
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
Message-ID: <20170517033139.GB9913@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 02:08:12PM +0300, Nikita Yushchenko wrote:
> > @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device *pdev)
> >  	}
> >  	sport->port.line = ret;
> >  	sport->lpuart32 = sdata->is_32;
> > +	lpuart_is_be = sdata->is_be;
> 
> Setting a global variable in per-device routine is quite bad design.
> 

There is a reason for that we don't want to change the exist 
lpuart32_read[write] API which is widely used in driver.
Making a global lpuart_is_be is the simplest way to do it.

Any strong blocking reason?

Regards
Dong Aisheng

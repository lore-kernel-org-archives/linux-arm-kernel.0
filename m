From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Tue, 12 Dec 2017 11:41:09 +0900
Subject: [PATCH 13/13] arc: do not use __print_symbol()
In-Reply-To: <12708a61-ebc7-8f3f-cef6-4a725047de6d@synopsys.com>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
 <20171211125025.2270-14-sergey.senozhatsky@gmail.com>
 <12708a61-ebc7-8f3f-cef6-4a725047de6d@synopsys.com>
Message-ID: <20171212024109.GA7798@jagdpanzerIV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (12/11/17 08:28), Vineet Gupta wrote:
> On 12/11/2017 04:53 AM, Sergey Senozhatsky wrote:
> > __print_symbol() uses extra stack space to sprintf() symbol
> > information and then to feed that buffer to printk()
> > 
> >    char buffer[KSYM_SYMBOL_LEN];
> > 
> >    sprint_symbol(buffer, address);
> >    printk(fmt, buffer);
> > 
> > Replace __print_symbol() with a direct printk("%pS") call.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> 
> Applied to arc for-curr

thanks.

	-ss

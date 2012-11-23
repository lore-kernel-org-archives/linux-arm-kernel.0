From: Barry.Song@csr.com (Barry Song)
Date: Fri, 23 Nov 2012 03:24:15 +0000
Subject: [RFC][PATCH] printk: add boot_quiet param to support deferred
 printk while booting
In-Reply-To: <20121123030729.GB4030@tarshish>
References: <1353639022-13273-1-git-send-email-Barry.Song@csr.com>
 <20121123030729.GB4030@tarshish>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9012297F567@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
Thanks!

> -----Original Message-----
> From: Baruch Siach [mailto:baruch at tkos.co.il]
> Sent: Friday, November 23, 2012 11:07 AM
> To: Barry Song
> Cc: gregkh at linuxfoundation.org; DL-SHA-WorkGroupLinux;
> linux-pm at lists.linux-foundation.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC][PATCH] printk: add boot_quiet param to support deferred
> printk while booting
> 
> Hi Barry,
> 
> On Fri, Nov 23, 2012 at 10:50:22AM +0800, Barry Song wrote:
> 
> [...]
> 
> > diff --git a/kernel/printk.c b/kernel/printk.c
> > index 2d607f4..0b88d6bf 100644
> > --- a/kernel/printk.c
> > +++ b/kernel/printk.c
> > @@ -250,6 +250,9 @@ static u32 clear_idx;
> >  #define LOG_ALIGN __alignof__(struct log)
> >  #endif
> >  #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
> > +static char __boot_log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
> 
> Since we do not use this buffer when the system is running, is there a way to
> release it once its content has been written to console?
> 

Definitely yes. at this moment the code is just a RFC to get people's agreement about the idea.

i have a note in my RFC if you didn't miss :-)
" Note: This is only a RFC, after we agree about the idea, i will move the boot_log_buf to __initdata."

> baruch
> 
> > +static int boot_log_len;
> > +
> >  static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
> >  static char *log_buf = __log_buf;
> >  static u32 log_buf_len = __LOG_BUF_LEN;
> > @@ -1247,6 +1250,16 @@ module_param(ignore_loglevel, bool, S_IRUGO |
> S_IWUSR);
> 

-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

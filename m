From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 00:11:26 -0700
Subject: [PATCH v2] ARM: prima2: fix incorrect panic usage
In-Reply-To: <1370575027-31671-1-git-send-email-haojian.zhuang@linaro.org>
References: <1370575027-31671-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130611071126.GH6688@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 11:17:07AM +0800, Haojian Zhuang wrote:
> In prima2, some functions of checking DT is registered in initcall
> level. If it doesn't match the compatible name of sirf, kernel
> will panic. It blocks the usage of multiplatform on other verndor.
> 
> The error message is in below.
> 
> Signen-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Knic - not syncing: unable to find compatible pwrc node in dtb          
>                                                                                 
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-rc3-00006-gd7f26ea-dirty #86   
> [<c0013adc>] (unwind_backtrace+0x0/0xf8) from [<c0011430>] (show_stack+0x10/0x1)
> [<c0011430>] (show_stack+0x10/0x14) from [<c026f724>] (panic+0x90/0x1e8)        
> [<c026f724>] (panic+0x90/0x1e8) from [<c03267fc>] (sirfsoc_of_pwrc_init+0x24/0x)
> [<c03267fc>] (sirfsoc_of_pwrc_init+0x24/0x58) from [<c0320864>] (do_one_initcal)
> [<c0320864>] (do_one_initcall+0x90/0x150) from [<c0320a20>] (kernel_init_freeab)
> [<c0320a20>] (kernel_init_freeable+0xfc/0x1c4) from [<c026b9e8>] (kernel_init+0)
> [<c026b9e8>] (kernel_init+0x8/0xe4) from [<c000e158>] (ret_from_fork+0x14/0x3c) 
> 
> Changelog:
> v2:
> 1. Fix the wrong error message.

Thanks, applied to fixes for 3.10, but I reworded the commit message a bit to
move the S-o-b down.


-Olof

From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Tue, 24 Sep 2013 10:02:40 -0300
Subject: [PATCH v5 1/4] media: s5p-tv: Replace mxr_ macro by default dev_
In-Reply-To: <1583471.Ys4OY3iSLA@amdc1032>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <13162989.WhfDRzW6dg@amdc1032> <52415ED9.3030407@samsung.com>
 <1583471.Ys4OY3iSLA@amdc1032>
Message-ID: <20130924100240.211dcaa3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 24 Sep 2013 12:33:34 +0200
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> escreveu:

> 
> Hi Tomasz,
> 
> On Tuesday, September 24, 2013 11:43:53 AM Tomasz Stanislawski wrote:
> > Hi,
> > 
> > On 09/23/2013 05:48 PM, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Hi Tomasz,
> > > 
> > > On Monday, September 23, 2013 04:50:01 PM Tomasz Stanislawski wrote:
> > >> Hello,
> > >> May I ask what is the rationale for this patch?
> > >> To reduce a few lines of code?
> > > 
> > > This patch makes source code more generic-like and easier to follow (mxd_r*
> > 
> > more generic(-like?) - NOT. Using mxr_ macros is a more generic way to produce logs
> 
> Using mxr_* macros is not more generic, don't be silly. :)

Let me give my 2 cents on it: it used to be common on media drivers to
define their own print macros. The rationale for that is because the
existing macros, on that time (kernel 2.2), weren't good enough[1].
Other drivers just followed it due to cut-and-paste.

However, nowadays, most developers are just sticking with the existing
common debug infrastructure (either dev_* or pr_* - being the last more
used). By using them, Kernel janitors can do a better job, as they may
have scripts already prepared to check issues there.

I prefer the usage of pr_* macros, as they allow debug messages to be
selectively enabled/disabled, if dynamic printk's are enabled. So,
a change like that actually improves the debug capability on a given 
driver.

So, IMHO, the better would be to change the patch to use pr_* macros,
and follow Joe's suggestions to improve it.

Regards,
Mauro


[1] on other drivers that create their own macros, the usual prefix is the
name of the driver (so, on em28xx, it is em28xx_dbg, and so on). In this 
case, the driver is s5p_tv. So, a macro following the old way should be 
called as s5p_tv_dbg. Yet, it is takes just a fraction of time to identify
them as printk-alike macros, as all those macros are similar.

Cheers,
Mauro

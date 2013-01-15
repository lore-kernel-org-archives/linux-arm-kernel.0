From: rtivy@ti.com (Tivy, Robert)
Date: Tue, 15 Jan 2013 23:06:07 +0000
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <CAK=WgbYwM2WPWrTp9U+nk_96RY3YYumzo0KxFpV0fDwU6dR+aA@mail.gmail.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
 <50F51E43.2090605@ti.com>
 <CAK=WgbbShpqxS7zrDs97HkjpyWq0xzW3b9KHLBBs_V3YzdJKiA@mail.gmail.com>
 <50F54B91.4030406@ti.com>
 <CAK=WgbYwM2WPWrTp9U+nk_96RY3YYumzo0KxFpV0fDwU6dR+aA@mail.gmail.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311FE9E0@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> Sent: Tuesday, January 15, 2013 4:49 AM
> To: Nori, Sekhar
> Cc: Tivy, Robert; davinci-linux-open-source; linux-arm; Ring, Chris;
> Grosen, Mark; rob at landley.net; linux-doc at vger.kernel.org; Chemparathy,
> Cyril
> Subject: Re: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
> OMAP-L138 DSP
> 
> On Tue, Jan 15, 2013 at 2:29 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> > May be rproc_alloc() could auto-assign the firmware name to something
> > like 'rproc%d-fw' if firmware name passed to it is NULL?
> 
> I prefer we use name-based filenames instead to make it easier for
> users (and us developers).
> 
> We can probably do something like "rproc-%s-fw" with pdata->name
> assuming we/you do maintain a meaningful name in the latter.

This sounds good, although it will introduce the need to handle dynamic storage for the generated name.  I think I can jam that storage on the end of the already-dynamically-sized 'struct rproc + sizeof(pdata)' allocation in rproc_alloc().

Thanks & Regards,

- Rob

> 
> Thanks,
> Ohad.

From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Jan 2013 10:46:56 +0530
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
Message-ID: <50F637C8.1050605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2013 6:19 PM, Ohad Ben-Cohen wrote:
> On Tue, Jan 15, 2013 at 2:29 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>> May be rproc_alloc() could auto-assign the firmware name to something
>> like 'rproc%d-fw' if firmware name passed to it is NULL?
> 
> I prefer we use name-based filenames instead to make it easier for
> users (and us developers).
> 
> We can probably do something like "rproc-%s-fw" with pdata->name
> assuming we/you do maintain a meaningful name in the latter.

Are you thinking of passing name of the remote processor (like m3, dsp0,
dsp1 etc) in pdata->name? That sounds OK since the processor name is
actually tied to the platform. BTW, the current driver seems to be
written for OMAP-L138 rather tightly so you could as well hardcode the
firmware name to 'rproc-dsp-fw'.

Thanks,
Sekhar

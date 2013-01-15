From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 16 Jan 2013 01:17:18 +0200
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311FE9E0@DFLE08.ent.ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
 <50F51E43.2090605@ti.com>
 <CAK=WgbbShpqxS7zrDs97HkjpyWq0xzW3b9KHLBBs_V3YzdJKiA@mail.gmail.com>
 <50F54B91.4030406@ti.com>
 <CAK=WgbYwM2WPWrTp9U+nk_96RY3YYumzo0KxFpV0fDwU6dR+aA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE9E0@DFLE08.ent.ti.com>
Message-ID: <CAK=WgbYZtg+B8EScHbqAH_pQzy5mzyT6xD++OmCNasAZPxy1rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 1:06 AM, Tivy, Robert <rtivy@ti.com> wrote:
> This sounds good, although it will introduce the need to handle dynamic storage for the generated name.  I think I can jam that storage on the end of the already-dynamically-sized 'struct rproc + sizeof(pdata)' allocation in rproc_alloc().

Or you can generate it when needed, without storing the result. This
rarely happens and anyway is negligible.

Thanks,
Ohad.

From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 23 Sep 2014 17:16:29 +0300
Subject: [PATCH 2/2] remoteproc: add support to handle internal memories
In-Reply-To: <54174082.4010008@ti.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
 <1404836521-59637-3-git-send-email-s-anna@ti.com>
 <CAK=WgbY-WmcJdnLHDf1CSkJqNBUeUMPTLcEZyLGKnECbxH1OAQ@mail.gmail.com>
 <53D7F6F3.9020804@ti.com>
 <CAK=WgbZ+NhA5AAhURUOojwnCbi2wYkJ11i-C5e7-kpZL5vD_3g@mail.gmail.com>
 <54174082.4010008@ti.com>
Message-ID: <CAK=WgbZanJYN7-vXW=wo0H40piauHGQHYPPppcCpc+6VapXmeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Mon, Sep 15, 2014 at 10:39 PM, Suman Anna <s-anna@ti.com> wrote:
> These processors need to use their internal RAM for loading, which is
> not for generic usage by the kernel, so defining a CMA block for this
> memory doesn't make sense.

Ok - so just to make sure I understand, this is physical memory you
want to use, which belongs to the remote processor, and which isn't
mapped normally by the kernel?

> Will it suffice to replace the memcpy() with memcpy_toio()?

Yes, memcpy_toio should be fine (and then you don't need to cast the
cookie returned by ioremap).

Thanks,
Ohad.

From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 14:05:03 +0300
Subject: [PATCH 08/17] i2c: omap: switch over to do {} while loop
In-Reply-To: <CAMQu2gw-rX9Xq7PPU9sGB=EFd4f3xfsPPDdODRyU5Jwg20v4GQ@mail.gmail.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-9-git-send-email-balbi@ti.com>
 <CAMQu2gw-rX9Xq7PPU9sGB=EFd4f3xfsPPDdODRyU5Jwg20v4GQ@mail.gmail.com>
Message-ID: <20120614110503.GN13602@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 04:33:39PM +0530, Shilimkar, Santosh wrote:
> On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> > this will make sure that we execute at least once.
> > No functional changes otherwise.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> Executing at least once instead of never is
> still a functional change :-)

there's a check for spurious interrupts. The idea was mainly to
initialise stat and bits correctly at the beginning of the handler.

Besides that "otherwise" is telling you that: "except this, there are no
other functional changes" ;)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/b423c3a0/attachment.sig>

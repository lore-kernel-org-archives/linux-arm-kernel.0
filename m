From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 14 Mar 2013 08:45:30 +1100
Subject: [PATCH] ARM: fix CONFIG_VIRT_TO_BUS handling
In-Reply-To: <201303131643.48506.arnd@arndb.de>
References: <201303131643.48506.arnd@arndb.de>
Message-ID: <20130314084530.88019561cedf9a96bd01193d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 13 Mar 2013 16:43:48 +0000 Arnd Bergmann <arnd@arndb.de> wrote:
>
> I'd like to merge this one through the arm-soc tree as a 3.9 bug fix
> unless there are objections.

The only problem is that, in the current arm-soc tree, VIRT_TO_BUS
depends on HAVE_VIRT_TO_BUS (since my first patch is in there but not the
second) ... that means that after this patch is applied you will get
warnings from the new "select VIRT_TO_BUS" statements (I think :-)).

Sorry about the mess.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/7984a6db/attachment.sig>

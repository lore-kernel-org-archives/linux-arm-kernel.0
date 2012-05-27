From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 27 May 2012 15:44:28 +0300
Subject: [PATCH v9 1/3] MTD: at91: extract hw ecc initialization to one
 function and use relaxed read/write
In-Reply-To: <1338038677-6752-2-git-send-email-josh.wu@atmel.com>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
 <1338038677-6752-2-git-send-email-josh.wu@atmel.com>
Message-ID: <1338122668.19389.4.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-05-26 at 21:24 +0800, Josh Wu wrote:
> use _relaxed read/write in most place. And use writel in operations of Control Register since it needs memory barrier.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

This should be split on 2 or even 3 parts:

1. You move definitions and things around.
2. You separate out the init stuff into a function
3. You start using _relaxed helpers.

And you should provide better commit messages. You should explain why
you do things - just cleanup? improvement? fix? preparation for
something?

I think this patch is too big, commit message is poor, patch does more
things than documented in the commit message.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120527/5b38f766/attachment.sig>

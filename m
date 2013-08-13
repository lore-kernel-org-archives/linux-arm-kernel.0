From: sleep_walker@suse.cz (Tomas Cech)
Date: Tue, 13 Aug 2013 02:34:07 +0200
Subject: [PATCH 11/16] arch/arm/mach-pxa/palmtreo.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-12-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376239917-15594-12-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130813003407.GA1390@venom>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 06:51:52PM +0200, Julia Lawall wrote:
>From: Julia Lawall <Julia.Lawall@lip6.fr>
>
>Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
>arity of the called function.
>
>The semantic match that makes this change is as follows:
>(http://coccinelle.lip6.fr/)
>
>// <smpl>
>@@
>expression e,f;
>@@
>
>f(...,
>- ARRAY_AND_SIZE(e)
>+ e,ARRAY_SIZE(e)
>  ,...)
>// </smpl>
>
>Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

I used to be happy with this macro as it improves readability.

but ack.


Tomas Cech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/699a1c41/attachment.sig>

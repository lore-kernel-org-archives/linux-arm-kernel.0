From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 16:32:42 +0200
Subject: [PATCH v3 3/4] simplefb: Change simplefb_init from module_init
 to fs_initcall
In-Reply-To: <1415885645-24613-3-git-send-email-hdegoede@redhat.com>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <1415885645-24613-3-git-send-email-hdegoede@redhat.com>
Message-ID: <5464C10A.30709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 15:34, Hans de Goede wrote:
> One of the reasons for having the simplefb nodes in /chosen, and doing
> explicit enumeration of the nodes there, is too allow enumerating them sooner,
> so that we get a console earlier on.
> 
> Doing this earlier then fs_initcall is not useful, since the fb only turns into
> a console when fbcon intializes, which is a fs_initcall too.

The above text is slightly confusing, as fbcon initializes at
module_init time. You only change it in the next patch. I can move the
fbcon change to be the first patch when applying, if there are no more
versions sent.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/ae9ffaad/attachment.sig>

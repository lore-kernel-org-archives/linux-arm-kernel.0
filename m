From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 16:34:46 +0200
Subject: [PATCH v3 4/4] fbcon: Change fbcon_init from module_init to
 fs_initcall
In-Reply-To: <1415885645-24613-4-git-send-email-hdegoede@redhat.com>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <1415885645-24613-4-git-send-email-hdegoede@redhat.com>
Message-ID: <5464C186.8030806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 15:34, Hans de Goede wrote:
> Various fb drivers register themselves before module_init so as to have a
> console as early as possible, this is of little use if fbcon does not initialze
> early too.
> 
> Fbcon cannot initialize earlier then fs_initcall, because then the creation
> of /sys/class/graphics/fbcon will fail.

Not related to this series, but makes me wonder how difficult it would
be to get fbcon and simplefb initialize at even earlier stage. Well,
something for the future.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/be9f184e/attachment.sig>

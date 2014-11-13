From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 17:20:58 +0200
Subject: [PATCH v5 0/5] simplefb: add clock handling code
In-Reply-To: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
References: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
Message-ID: <5464CC5A.7010508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/14 18:15, Hans de Goede wrote:
> Hi Tomi,
> 
> Here is v5 of my simplefb patch-set, this time with an Ack from
> Grant Likely for the dt-bindings bits, which should end all controversy
> surrounding that patch.
> 
> For changes since the original postings please see the per patch changelogs
> in the patch commit messages.
> 
> Please merge this into your tree for 3.19.

I applied this and the "dt-bindings: simplefb: Specify node location and
handoff related properties" v3 series to my test branch, compiled for
x64 and:

drivers/video/fbdev/simplefb.c: In function ?simplefb_clocks_init?:
drivers/video/fbdev/simplefb.c:204:2: error: implicit declaration of
function ?of_clk_get_parent_count? [-Werror=implicit-function-declaration]
  par->clk_count = of_clk_get_parent_count(np);
  ^
In file included from include/linux/i2c.h:33:0,
                 from include/uapi/linux/fb.h:5,
                 from include/linux/fb.h:5,
                 from drivers/video/fbdev/simplefb.c:24:
drivers/video/fbdev/simplefb.c: In function ?simplefb_init?:
drivers/video/fbdev/simplefb.c:399:25: error: ?of_chosen? undeclared
(first use in this function)
  for_each_child_of_node(of_chosen, np) {
                         ^
include/linux/of.h:736:33: note: in definition of macro
?for_each_child_of_node?
  for (child = of_get_next_child(parent, NULL); child != NULL; \
                                 ^
drivers/video/fbdev/simplefb.c:399:25: note: each undeclared identifier
is reported only once for each function it appears in
  for_each_child_of_node(of_chosen, np) {
                         ^
include/linux/of.h:736:33: note: in definition of macro
?for_each_child_of_node?
  for (child = of_get_next_child(parent, NULL); child != NULL; \
                                 ^

We need "depends on OF"?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/dec60d24/attachment.sig>

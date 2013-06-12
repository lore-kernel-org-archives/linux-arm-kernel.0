From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 11:25:48 +0100
Subject: [PATCH 05/14] bus: mvebu-mbus: Update the mbus-compatible node's
 ranges property
In-Reply-To: <1370623671-7748-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130612102548.A08003E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Jun 2013 13:47:42 -0300, Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
> Ideally 'ranges' entry should be added in device tree source files.
> However, since those properties do not inherit the entries from included
> files it would be a duplication hell, which means a nightmare to
> maintain.
> 
> So, instead of hardcoding the required translation entries, we update
> them programatically, whenever a decoding window is allocated.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

I'm in the middle of reading through this thread, and I'll have some
better comments for you then, but in the mean time I wanted to reply to
this patch.

As far as the kernel is concerned, the DT is *not* a live structure. It
is a static description of the system.  There are cases where we do
runtime updates to the tree, but those are restricted to either fixups
for broken trees, or because firmware told us to at runtime. Modifying
the data in the tree out of convenience has all kinds of problems.
Rather, the data in the tree should make it clear that there is a gap in
the translation from one node to another and defer to the bus driver to
provide a custom translation when requested without modifying the tree.

g.

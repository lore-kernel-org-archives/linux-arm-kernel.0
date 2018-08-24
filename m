From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 24 Aug 2018 16:32:47 +0200
Subject: [PATCH] drm/sun4i: tcon-top: Use struct_size() in devm_kzalloc()
In-Reply-To: <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
References: <20180824010521.GA25451@embeddedor.com>
 <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
Message-ID: <20180824143247.7lxwsckmkyaiqzob@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 07:56:12PM -0700, Kees Cook wrote:
> On Thu, Aug 23, 2018 at 6:05 PM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> >
> > struct foo {
> >         int stuff;
> >         void *entry[];
> > };
> >
> > instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> >
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> >
> > instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
> >
> > This issue was detected with the help of Coccinelle.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180824/dd2079b0/attachment.sig>

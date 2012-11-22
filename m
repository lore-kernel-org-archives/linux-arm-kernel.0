From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 22 Nov 2012 06:41:38 +0100
Subject: [PATCH 1/4] OF: Add helper for matching against linux,stdout-path
In-Reply-To: <CACxGe6tyPpjx4OtjHmhB9Cvnb7OwAjPEE4=K+wgWKYHcAV-ESQ@mail.gmail.com>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
 <CACxGe6tyPpjx4OtjHmhB9Cvnb7OwAjPEE4=K+wgWKYHcAV-ESQ@mail.gmail.com>
Message-ID: <20121122054138.GY4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:03 Wed 21 Nov     , Grant Likely wrote:
> On Wed, Nov 21, 2012 at 3:57 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > devicetrees may have a linux,stdout-path or stdout-path property
> > in the chosen node describing the console device. This adds a helper
> > function to match a device against this property and retrieve the options
> > so a driver can call add_preferred_console for a matching device.
> 
> NIce. Looks like the right behaviour, but is a little inefficient.
> Since the stdout property doesn't change this code could be called
> once right after the tree is unflattened and then cache the pointer to
> the node anarguments. Can you add the code to of_alias_scan()?
do we assume that we can have only one stdout-path?

I think we could have more serial, framebuffer console

Best Regards,
J.

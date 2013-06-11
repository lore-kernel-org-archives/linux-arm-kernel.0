From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jun 2013 13:10:03 +0100
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <CAGsJ_4wH=mNxBTqizKjJR2YhmVQa=iprfUmVYy8oz7MZeLfkqg@mail.gmail.com>
References: <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
 <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
 <20130610134535.GB2987@katana>
 <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ@mail.gmail.com>
 <20130611084827.GS1403@sirena.org.uk>
 <CAGsJ_4wH=mNxBTqizKjJR2YhmVQa=iprfUmVYy8oz7MZeLfkqg@mail.gmail.com>
Message-ID: <20130611121003.GC1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 07:13:33PM +0800, Barry Song wrote:
> 2013/6/11 Mark Brown <broonie@kernel.org>:

> > It's not that people don't care about these users, it's that people
> > don't care too much about out of tree users.  Part of the goal here is
> > to convince people working on such applications that they should make
> > mainline better for everyone so that you don't need external code to
> > make the kernel useful.

> Mark, then this is really confusing me.
> for this reason, the target should be making this out-of-tree stuff be
> inside the tree. to make i2c-sirf "mainline better and not need
> external code", the target should be making this external code not
> external but become internal. otherwise, my mainline users will always
> need this external code.

It's not just this one bit of code that they're relying on, this also
gets built on with other things that are also out of tree.  The thing
we need to do is figure out what problem the solution as a whole is
fixing and then make sure that mainline can deal with that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/b4eb3389/attachment.sig>

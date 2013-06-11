From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 11 Jun 2013 19:13:33 +0800
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <20130611084827.GS1403@sirena.org.uk>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
 <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
 <20130610134535.GB2987@katana>
 <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ@mail.gmail.com>
 <20130611084827.GS1403@sirena.org.uk>
Message-ID: <CAGsJ_4wH=mNxBTqizKjJR2YhmVQa=iprfUmVYy8oz7MZeLfkqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/11 Mark Brown <broonie@kernel.org>:
> On Tue, Jun 11, 2013 at 09:14:41AM +0800, Barry Song wrote:
>
>> the mainline idea you mentioned is that you don't care about any early
>> device, which means some devices want to start earlier than others in
>> some real automative user scenerioes.
>> but i think another important idea is that mainline codes come from
>> branches of different vendors and serve final users of those drivers,
>> but not only make source codes no difference to all environments. the
>> auto users i2c-sirf serves, here, actually means some differences with
>> PC/tablet/mobilephone. we don't make codes good-looking by losing
>> functionality and not close to final users.
>
> It's not that people don't care about these users, it's that people
> don't care too much about out of tree users.  Part of the goal here is
> to convince people working on such applications that they should make
> mainline better for everyone so that you don't need external code to
> make the kernel useful.

Mark, then this is really confusing me.
for this reason, the target should be making this out-of-tree stuff be
inside the tree. to make i2c-sirf "mainline better and not need
external code", the target should be making this external code not
external but become internal. otherwise, my mainline users will always
need this external code.

-barry

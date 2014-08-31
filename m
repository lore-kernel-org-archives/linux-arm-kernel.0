From: rabin@rab.in (Rabin Vincent)
Date: Sun, 31 Aug 2014 16:59:21 +0200
Subject: [PATCH v4 7/8] ARM: mm: allow non-text sections to be
 non-executable
In-Reply-To: <CAGXu5j+OnpaZAJRsSsR=iid8178p+4hR5xzrJ7N3F94DZ7DYMg@mail.gmail.com>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
 <1407949593-16121-8-git-send-email-keescook@chromium.org>
 <20140819123342.GJ23128@arm.com>
 <CAGXu5jLnXeavr4E4YF9jtB03iA-y4vLZjf83a8ABzUC-hdkz9w@mail.gmail.com>
 <20140826144303.GX23445@arm.com>
 <CAGXu5j+OnpaZAJRsSsR=iid8178p+4hR5xzrJ7N3F94DZ7DYMg@mail.gmail.com>
Message-ID: <20140831145921.GA4931@dator>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 09:04:41AM -0700, Kees Cook wrote:
> On Tue, Aug 26, 2014 at 7:43 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Hmm, so do you mandate that preemption is disabled during sections of code
> > where the permissions must be changed after boot? (e.g. ftrace patching)
> 
> I guess it's not enforced (how do I make sure preempt is off?), but
> it's only used during the ftrace patching. I'm open to suggestions! (I
> had avoided going the fixmap route since I would have expected that to
> be much slower.)

For ftrace patching this is called under stop_machine() so preemption is
already off there.

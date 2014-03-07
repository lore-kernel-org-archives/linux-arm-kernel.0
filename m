From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 21:16:33 -0500
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <CACRpkdZRJG-TzN4c3NSH9PqcQzpo6EbEn5_bM-P3sh4_vSjtaA@mail.gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
 <20140226000940.GF1872@titan.lakedaemon.net>
 <CACRpkdYQa2BG_qxf5zY=7rks6O31ZF-BX0af3_u1MOgwfwxFSQ@mail.gmail.com>
 <20140226145345.GG1872@titan.lakedaemon.net>
 <CACRpkdZRJG-TzN4c3NSH9PqcQzpo6EbEn5_bM-P3sh4_vSjtaA@mail.gmail.com>
Message-ID: <20140307021633.GN1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 09:26:48AM +0800, Linus Walleij wrote:
> On Wed, Feb 26, 2014 at 10:53 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Wed, Feb 26, 2014 at 10:43:45AM +0100, Linus Walleij wrote:
> 
> >> Actually, I'd prefer to pull it in, rebase and sign off each patch
> >> individually in my tree if that is not causing you problems.
> >
> > Actually, that would mess us up pretty badly. :(
> 
> OK so I didn't do this, I just pulled it in :-)

I could tell, Stephen would have had a heart attack :)

> >> That way it is visible that the patches were funneled through pin
> >> control.
> >
> > I'm a little confused by this.  Once you merge the branch into one of
> > yours, that merge commit is a part of the history.
> 
> Yes this has been discussed in the past.

Would you have a link handy?  My first thought was to create a tag, eg
"Sent-through: subsystem <maintainer@example.com>" that I would add to
patches as I pull them in.  After all, I know where I'm sending them.
Or should at any rate.

> But when a developer bisects down to a certain commit and just looks
> at it with git log there is no telling which subsystem this thing came
> from and who actually funnelled it to Torvalds.

True.

> I do know you *can* find that out with some git magic, the problem
> is that it is so magic that most developers don't know it and just
> look at the signoffs.

It would be helpful if there were a complement to 'git merge-base', say
'git merge-tip' to point to the merge commit that joined the branch
containing commit X.

Run in succession, it would yield committers me (I merged pinctrl-dove
into pinctrl), you, Torvalds.

> But it's not like I care super-much.

Well, if the code is perfect, we don't have to worry about a lazy
developer bisecting down to one of our commits. ;-)

btw - I have one last pull request I'll be sending tomorrow that's a
couple of commits on top of what you currently have.  It's very small,
but we're avoiding locking ourselves into supporting a bad DT ABI.  The
real code change just downgrades a WARN().  The rest is correcting the
binding doc.

thx,

Jason.

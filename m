From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Mar 2014 11:54:47 +0800
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <20140307034747.GP1872@titan.lakedaemon.net>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
 <20140226000940.GF1872@titan.lakedaemon.net>
 <CACRpkdYQa2BG_qxf5zY=7rks6O31ZF-BX0af3_u1MOgwfwxFSQ@mail.gmail.com>
 <20140226145345.GG1872@titan.lakedaemon.net>
 <CACRpkdZRJG-TzN4c3NSH9PqcQzpo6EbEn5_bM-P3sh4_vSjtaA@mail.gmail.com>
 <20140307021633.GN1872@titan.lakedaemon.net>
 <20140307034747.GP1872@titan.lakedaemon.net>
Message-ID: <CACRpkdZnseVr8DZKu7Z_Q4uOvWybSs4uhM+JQK_L8u+KJ2myJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 11:47 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Thu, Mar 06, 2014 at 09:16:33PM -0500, Jason Cooper wrote:
>> On Fri, Mar 07, 2014 at 09:26:48AM +0800, Linus Walleij wrote:
>> > On Wed, Feb 26, 2014 at 10:53 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> ...
>> > > I'm a little confused by this.  Once you merge the branch into one of
>> > > yours, that merge commit is a part of the history.
>> >
>> > Yes this has been discussed in the past.
>>
>> Would you have a link handy?  My first thought was to create a tag, eg
>> "Sent-through: subsystem <maintainer@example.com>" that I would add to
>> patches as I pull them in.  After all, I know where I'm sending them.
>> Or should at any rate.
>>
>> > But when a developer bisects down to a certain commit and just looks
>> > at it with git log there is no telling which subsystem this thing came
>> > from and who actually funnelled it to Torvalds.
>>
>> True.
>>
>> > I do know you *can* find that out with some git magic, the problem
>> > is that it is so magic that most developers don't know it and just
>> > look at the signoffs.
>>
>> It would be helpful if there were a complement to 'git merge-base', say
>> 'git merge-tip' to point to the merge commit that joined the branch
>> containing commit X.
>>
>> Run in succession, it would yield committers me (I merged pinctrl-dove
>> into pinctrl), you, Torvalds.
>
> grrr.  Couldn't let it go.  If you add this alias:
>
>   merged-by-who = log --ancestry-path --reverse --merges --format=\"%h %cD \\\"%cN <%cE>\\\"\"
>
> to you ~/.gitconfig, then
>
> $ git merged-by-who 2c4b229bafcf..pinctrl/for-next
> 08d4f0c8b131 Sat, 1 Mar 2014 07:03:36 +0000 "Jason Cooper <jason@lakedaemon.net>"
> 7cab36e5eee9 Sat, 1 Mar 2014 07:03:52 +0000 "Jason Cooper <jason@lakedaemon.net>"
> cdfe3175eb90 Mon, 3 Mar 2014 13:39:20 +0800 "Linus Walleij <linus.walleij@linaro.org>"
> a9ea2ed45a22 Mon, 3 Mar 2014 13:40:22 +0800 "Linus Walleij <linus.walleij@linaro.org>"
> 7bd0df13646d Wed, 5 Mar 2014 17:12:17 +0800 "Linus Walleij <linus.walleij@linaro.org>"

nifty alias, I added it to my .gitconfig.

Yours,
Linus Walleij

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 11:11:47 +0000
Subject: [GIT PULL] at91: fist cleanup branch for 3.5
In-Reply-To: <CAOesGMg4fJD9ojem_Z2ZZTswK10TwNMtBMncPYhQS9ozmPfqbg@mail.gmail.com>
References: <4F8D9037.9010401@atmel.com> <201204222032.48694.arnd@arndb.de>
 <CAOesGMg4fJD9ojem_Z2ZZTswK10TwNMtBMncPYhQS9ozmPfqbg@mail.gmail.com>
Message-ID: <201204231111.47448.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 April 2012, Olof Johansson wrote:
> There, I had this workflow:
> 
> * git fetch <url+branch from pull request>
> * tig FETCH_HEAD   (look at contents, sanity check, etc: If something
> looks wrong there's no merge to undo)
> * git checkout -b subarch/topic FETCH_HEAD     to create the pulled-in
> topic branch
> * git checkout next/topic
> * git pull --log <url+branch from pull request>    to get the original
> URL in the merge commit
> 
> Then the usual steps to get it into for-next and added to the contents file.

Ok. I've now started skipping the 'checkout -b' step and just doing
a 'git branch subarch/topic FETCH_HEAD', but the result is the same.

> That way we do get the --log in the next/ branch as well as the tag
> message, but only one merge changeset. It also has the benefit of
> making it trivial to see when things have been merged with mainline
> which branches can be pruned and not.
> 
> The only thing missing from that workflow is the authenticity of the
> subarch/topic branch once it's done, in case there is tinkering with
> the arm-soc repo by some third party. I don't think that's a big risk
> since we tend to diff the for-next contents before and after a
> rebuild, so any delta in file contents will be caught. Since each
> branch is documented in arm-soc-for-next-contents, we should have all
> bases covered there.

I also catch changes to the branches when I update my tree.

> I guess we could tag every subarch/topic tip as well, but it'll get
> pretty noisy with all them in the main repo. We have the option of
> pushing those to a separate repo instead of the main arm-soc.git if we
> wanted though.

The idea I've had before is to just keep tags for each subarch/topic
instead of branches, which would seperate them from one another, and
we could leave the message in the tag without it cluttering the history.

The main disadvantage I see in that is that I don't have a good workflow
for maintaining remote tags yet.

	Arnd

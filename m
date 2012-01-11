From: mchehab@infradead.org (Mauro Carvalho Chehab)
Date: Wed, 11 Jan 2012 08:35:34 -0200
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
In-Reply-To: <Pine.LNX.4.64.1201110933480.1191@axis700.grange>
References: <20120111133146.990e2b7115c9fa80e8fc3234@canb.auug.org.au>
 <CAOesGMh0W1hvpySB8jtVBojZtoniHXur98Bzq1Feh3vAD4CkOg@mail.gmail.com>
 <Pine.LNX.4.64.1201110933480.1191@axis700.grange>
Message-ID: <4F0D65F6.8080209@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-01-2012 06:36, Guennadi Liakhovetski wrote:
> On Tue, 10 Jan 2012, Olof Johansson wrote:
> 
>> On Tue, Jan 10, 2012 at 6:31 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi Mauro,
>>>
>>> Today's linux-next merge of the v4l-dvb tree got conflicts in a large
>>> number of files between commits from the arm-soc tree and commits from the
>>> v4l-dvb tree.  You have rebased the v4l-dvb tree onto v3.2 while the
>>> arm-soc tree had merged a previous version. you have then added a lot
>>> more commits on top of the result - which produces all the conflicts.  :-(
>>>
>>> This is exactly the sort of pain I alluded to when I first noted that the
>>> v4l-dvb tree had been merged into the arm-soc tree ...
>>
>> We do this every now and then though, it's not an issue as long as
>> nothing stupid is done with the dependent branch at the other end.
>> I.e. if it's actually a stable branch (which we got promised that it
>> was).
>>
>> So, why was the whole v4l tree rebased? Guennadi, you said it was
>> going to be a stable branch? What happened?
> 
> Sorry, I don't think I _promised_ anything, I even don't think I said 
> anything at all about the stability of that branch. On the contrary - I 
> suggested you to only take _one_ patch, about which we knew, that some ARM 
> patches depended upon, for which I've got Mauro's ack. This has been done 
> with the sole purpose for you to avoid any dependencies. Instead you 
> decided to pull the whole branch.

What I and Guennadi agreed (http://linuxtv.org/irc/v4l/index.php?date=2012-01-05)
were to do just the reverse:

He would be sending you one single patch with my ack, that would allow the 
arm tree to be merged [1], I would wait for a few days for the arm tree to
be pulled, and then I would rebase my -next tree to remove that patch
from it.

[1] http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/commitdiff/88c6599d97b489ac543fa352159a81f60bddded7

My -next tree were never meant to be stable. It is just a patch repository
where I merge from the real development repository, in order to test them
against the hole changes. From time to time, when bad things happen
(patch conflicts, compilation breakages, requests to remove bad patches),
I just rebase it.

The media stable tree is stored elsewhere, but it contains the sort of patches
that Linus once asked me to not send him: merge patches from upstream
that are sometimes needed, due to some conflict dependencies. This time,
there are two of such patches inside my tree. That's a second reason
for me to rebase.

>>> Not happy.
>>
>> No kidding.  Mauro, can you undo your rebase or should I remove the
>> dependent branch (and the at91 branch that needs it) from arm-soc
>> instead?

I prefer if you could just pick this patch from Guennadi's tree:
 http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/commitdiff/88c6599d97b489ac543fa352159a81f60bddded7

and add my ack on it, removing the v4l-dvb merge from yours.

Linus seems to prefer to have the arch trees merged before the drivers
tree, with makes sense.

Regards,
Mauro
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

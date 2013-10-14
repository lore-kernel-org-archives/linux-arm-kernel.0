From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Oct 2013 00:23:59 +0200
Subject: [PATCH v3 3/3] ARM: add support for bit sliced AES using NEON
 instructions
In-Reply-To: <20131014152826.GP25034@n2100.arm.linux.org.uk>
References: <CAKv+Gu81Bb8jzVUgyS_=meJNLQaxydLLRR-5n5gY8b-reofzUQ@mail.gmail.com>
 <20131013112239.GD25034@n2100.arm.linux.org.uk>
 <CAKv+Gu--TmG3FxAHSYN_RG2FiLabFRCdp4vn1nrMOdOdfzgMwA@mail.gmail.com>
 <20131013113049.GE25034@n2100.arm.linux.org.uk>
 <20131014112921.GA15084@gondor.apana.org.au>
 <20131014120837.GM25034@n2100.arm.linux.org.uk>
 <20131014121021.GA15351@gondor.apana.org.au>
 <20131014121926.GN25034@n2100.arm.linux.org.uk>
 <20131014124700.GA15660@gondor.apana.org.au>
 <20131014125019.GO25034@n2100.arm.linux.org.uk>
 <20131014152826.GP25034@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9z-32q9n4iAzFABpXwX04dkFkOpkP9mC8he4RQgZVzuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

If you're still interested, I have cherry-picked the commit from
Herbert's tree on top of the branch you pulled from me.

git://git.linaro.org/people/ardbiesheuvel/linux-arm.git arm-aesbs


Regards,
Ard.



On 14 October 2013 17:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 14, 2013 at 01:50:19PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Oct 14, 2013 at 08:47:00PM +0800, Herbert Xu wrote:
>> > On Mon, Oct 14, 2013 at 01:19:26PM +0100, Russell King - ARM Linux wrote:
>> > > On Mon, Oct 14, 2013 at 08:10:21PM +0800, Herbert Xu wrote:
>> > > > On Mon, Oct 14, 2013 at 01:08:37PM +0100, Russell King - ARM Linux wrote:
>> > > > > On Mon, Oct 14, 2013 at 07:29:21PM +0800, Herbert Xu wrote:
>> > > > > > On Sun, Oct 13, 2013 at 12:30:49PM +0100, Russell King - ARM Linux wrote:
>> > > > > > > Herbert,
>> > > > > > >
>> > > > > > > Could I have a git URL to pull the above commit please?
>> > > > > >
>> > > > > > Russell, do you want me to revert this patch from cryptodev?
>> > > > > > Otherwise I'm not quite sure what you want me to do here.
>> > > > >
>> > > > > I'd like to pull a branch from you containing this commit to solve the
>> > > > > build error I'm getting with my tree, so I can continue testing my tree.
>> > > > > At the moment, this is an additional unnecessary cause of randconfig
>> > > > > build failures.
>> > > >
>> > > > I don't have a branch that contains just this patch so perhaps it
>> > > > would be easiest if I just reverted it?
>> > >
>> > > Well, I don't have it either.
>> >
>> > Oh you were talking about the ablk_helper patch, and not some ARM
>> > patch that sneaked into the crypto tree.
>> >
>> > As it's a crypto driver that's being added then it should go
>> > through the crypto tree.  If it depends on some ARM bits that's
>> > only in linux-next then I could try to merge that, assuming the
>> > underlying ARM tree is stable.
>>
>> You're not listening to me.  I've had enough of trying to discuss this
>> sensibly.  I'm reverting all of Ard's work, and my commit to fix up a
>> missing .gitignore entry afterwards.  Congratuations.
>
> Scrap that, I can't revert the merge resulting from the pull, because it
> brought in everything between -rc1 and rc3, and git is trying to revert
> everything in mainline between those two when I try and re-merge this
> branch.
>
> So I can't revert this.

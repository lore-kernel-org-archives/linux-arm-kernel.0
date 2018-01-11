From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Jan 2018 10:17:56 +0100
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
In-Reply-To: <20180111084128.GA16780@kroah.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180110101755.GA5822@kroah.com>
 <006c4a95-9299-bd17-6dec-52578e8461ae@linux.intel.com>
 <20180110191703.GA20248@kroah.com>
 <8997e43c-683e-418d-4e2b-1fe3fefe254e@linux.intel.com>
 <20180110202740.GA27703@kroah.com>
 <e81095ff-d491-9977-25e6-7ba6d28d5e72@linux.intel.com>
 <20180111073038.GA3600@kroah.com>
 <CACPK8Xe9Jti8S2px=QOcSMA2v+TZ4eGDGQND4qmBUBXeBpsBZQ@mail.gmail.com>
 <20180111084128.GA16780@kroah.com>
Message-ID: <CAK8P3a1xfo_p9Zi0BpP8cvXhkSrMynf=eQ=GkmJwDGf+Jb5O2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 9:41 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Jan 11, 2018 at 12:28:48AM -0800, Joel Stanley wrote:
>> On Wed, Jan 10, 2018 at 11:30 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Jan 10, 2018 at 01:46:34PM -0800, Jae Hyun Yoo wrote:
>> >> Thanks for your pointing it out and I totally agree with you. Actually, we
>> >> are preparing 4.13 update for now and an another update will be followed up.
>> >> As I answered above, I'll rebase this patch set onto the latest kernel.org
>> >> mainline. Sorry for my misunderstanding of upstream process.
>> >
>> > 4.13?  Why that kernel?  It too is obsolete and insecure and
>> > unsupported.
>>
>> It contains support for our hardware that I have integrated from work
>> in progress patches and upstream commits.
>>
>> The OpenBMC project, with myself as the kernel maintainer, have
>> intentions to regularly move to upstream releases. This takes time and
>> effort. This time and effort is balanced with submitting our drivers
>> upstream.
>
> Of course, but please do not have your "users" use a kernel that is
> known to have bugs and can not be supported.  That would not be good at
> all, don't you think?

I've been pretty happy with the progress in merging drivers upstream
for OpenBMC. Of course things always take longer than planned,
but they are getting there. Most servers today are probably running
the aspeed vendor kernel based on linux-2.6.28.10, at least that's
what my workstation runs (and no, I did not connect the BMC to my
home network).

The particular choices of mainline versions (4.10 and 4.13) may be
unfortunate as they are both one off from a longterm release, but
not being stuck on 2.6 is the important first step in order to upstream
stuff.

>> Another silicon vendor has recently joined the project and that brings
>> an entire SoC that is not upstream. We have patches on the ARM that
>> are under review for this SoC, with more drivers undergoing cleanup in
>> order to submit them to the relevant maintainers.
>
> Why are you merging all SoC trees together into one place?  That seems
> like a nightmare to manage, especially with git.

Why would anyone want to have multiple kernel trees just to run
things on different SoCs? ;-)

It's just a collection of device drivers in different stages of getting
upstreamed.

>> > And if you do have out-of-tree code, why not use a process that makes it
>> > trivial to update the base kernel version so that you can keep up to
>> > date very easily?  (hint, just using 'git' is not a good way to do
>> > this...)
>>
>> We have a process that we've been developing under for the past few
>> years. I find git to be a great tool for managing Linux kernel trees.
>>
>> What would you recommend for managing kernel trees?
>
> quilt is best for a tree that you can not rebase (i.e. a public git
> tree).  Otherwise you end up getting patches all mushed together and
> hard to extract in any simple way.

I'm ususally happy with having git with topic branches to make the
rebasing easier. In many cases, you can just leave a topic branch
for a particular subsystem unchanged between versions and just
merge the latest version of those branches until the branch goes
away after upstreaming.

        Arnd

From: joel@jms.id.au (Joel Stanley)
Date: Thu, 11 Jan 2018 00:28:48 -0800
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
In-Reply-To: <20180111073038.GA3600@kroah.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180110101755.GA5822@kroah.com>
 <006c4a95-9299-bd17-6dec-52578e8461ae@linux.intel.com>
 <20180110191703.GA20248@kroah.com>
 <8997e43c-683e-418d-4e2b-1fe3fefe254e@linux.intel.com>
 <20180110202740.GA27703@kroah.com>
 <e81095ff-d491-9977-25e6-7ba6d28d5e72@linux.intel.com>
 <20180111073038.GA3600@kroah.com>
Message-ID: <CACPK8Xe9Jti8S2px=QOcSMA2v+TZ4eGDGQND4qmBUBXeBpsBZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:30 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 10, 2018 at 01:46:34PM -0800, Jae Hyun Yoo wrote:
>> Thanks for your pointing it out and I totally agree with you. Actually, we
>> are preparing 4.13 update for now and an another update will be followed up.
>> As I answered above, I'll rebase this patch set onto the latest kernel.org
>> mainline. Sorry for my misunderstanding of upstream process.
>
> 4.13?  Why that kernel?  It too is obsolete and insecure and
> unsupported.

It contains support for our hardware that I have integrated from work
in progress patches and upstream commits.

The OpenBMC project, with myself as the kernel maintainer, have
intentions to regularly move to upstream releases. This takes time and
effort. This time and effort is balanced with submitting our drivers
upstream.

> What keeps you all from just always tracking the latest tree from Linus?

Linus' tree does not contain all of the drivers required to boot
systems. Many of them are still under review on lkml, and others still
require rewrite from the vendor tree.

> What is in your tree that is not upstream that requires you to have a
> kernel tree at all?

We have PECI, video compression, crypto, USB CDC, DRM (graphics),
serial GPIO, LPC mailbox for the ASPEED SoC.

Another silicon vendor has recently joined the project and that brings
an entire SoC that is not upstream. We have patches on the ARM that
are under review for this SoC, with more drivers undergoing cleanup in
order to submit them to the relevant maintainers.

>
> And if you do have out-of-tree code, why not use a process that makes it
> trivial to update the base kernel version so that you can keep up to
> date very easily?  (hint, just using 'git' is not a good way to do
> this...)

We have a process that we've been developing under for the past few
years. I find git to be a great tool for managing Linux kernel trees.

What would you recommend for managing kernel trees?

Cheers,

Joel

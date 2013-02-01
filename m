From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Jan 2013 21:46:10 -0700
Subject: [GIT PULL 5/8] ARM: tegra: SCU base rework
In-Reply-To: <CAOesGMjjgz7Am7-D_fQHqgLX=G+Wc_LKL-GYMHd1-NzVC-DUfA@mail.gmail.com>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
 <1359582159-28816-5-git-send-email-swarren@wwwdotorg.org>
 <20130201043222.GC5844@quad.lixom.net>
 <CAOesGMjjgz7Am7-D_fQHqgLX=G+Wc_LKL-GYMHd1-NzVC-DUfA@mail.gmail.com>
Message-ID: <510B4892.3050900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 09:35 PM, Olof Johansson wrote:
> On Thu, Jan 31, 2013 at 8:32 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, Jan 30, 2013 at 02:42:36PM -0700, Stephen Warren wrote:
>>> Tegra currently relies on the SCU to determine the number of CPU
>>> cores, and also hard-codes the SCU physical address.
>>>
>>> This series adds a /cpus node to the Tegra device tree, and updates
>>> the code to rely solely on that to determine the CPU count. A new
>>> API is introduced to query for the existence of SCU registers, and the
>>> SCU register address. Tegra and OMAP2 are converted to use these new
>>> APIs.
>>>
>>> This pull request is based on a merge of v3.8-rc3, and arm-soc's
>>> depends/rmk-perf branch.
>>
>> This one looks like it should also be based on your cleanup, since it has
>> conflicts with it. Please rebase accordingly.
> 
> By the way, just in case this looks like a random request...
> 
> A few merge conflicts between independent topic branches is not a big
> deal; we can deal with those.
> 
> What's somewhat annoying though, is when a previous cleanup branch
> conflicts with later features. So, please base features on top of
> cleanups accordingly.

Hmm. And here I was thinking that I was basing branches on top of
each-other too much given your previous comments about merge conflicts
being OK!

In case it helps, the following commit in linux-next shows the conflict
resolution:

ee05948 Merge branch 'for-3.9/scu-base-rework' into for-3.9/soc-t114

I guess I missed this because I didn't merge for-3.9/scu-base-rework
into my for-next on its own, but only as part of for-3.9/soc-t114,
within which I had resolved the conflict as above.

So, you could just skip this pull request, and it'll be pulled in when
you merge for-3.9/soc-t114.

It that doesn't work for you, I can do the rebase tomorrow morning.

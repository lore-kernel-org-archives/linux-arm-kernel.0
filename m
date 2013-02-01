From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 1 Feb 2013 10:10:37 -0500
Subject: [PATCH v4 00/13] ARM LPAE Fixes - Part 1
In-Reply-To: <alpine.LFD.2.02.1301312252230.6300@xanadu.home>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1301312252230.6300@xanadu.home>
Message-ID: <510BDAED.8060805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On 01/31/2013 11:00 PM, Nicolas Pitre wrote:
> On Thu, 31 Jan 2013, Cyril Chemparathy wrote:
>
>> This series is a repost of the LPAE related changes in preparation for the
>> introduction of the Keystone sub-architecture.  The original series has now
>> been split, and this particular series excludes the earlier changes to the
>> runtime code patching implementation.  Earlier versions of this series can be
>> found at [1], [2], [3] and [4].
>>
>> These patches are also available in git:
>> git://git.kernel.org/pub/scm/linux/kernel/git/cchemparathy/linux-keystone.git upstream/keystone-lpae-v4
>
> This part 1 looks very nice.  It received many review cycles already as
> well.  It would be about time it goes upstream.
>
> I think it is ready to be merged in Russell's tree.  Feel free to send
> him a pull request whenever you're ready.
>

Great.  I'll apply your acks and post a pull request.

> Then we'll be free to look at the more controvertial p2v patching stuff.
>

On the P2V patching stuff, I've implemented an alternative approach to 
get past this problem.  Essentially, the new implementation retains the 
kernel location detection part, but avoids the code patching by using 
simple inline P2V and V2P functions that use the offset detected early 
on in boot.

With this, I ran simple network and filesystem performance tests to 
compare the code-patching vs. non-code-patching variants.  These tests 
didn't yield any significant performance difference between the two on 
an ARMv7 (Cortex-A8) platform.

This series is basically operational at this point, but it needs a bit 
more test coverage before I post it out.

Thanks
-- Cyril.

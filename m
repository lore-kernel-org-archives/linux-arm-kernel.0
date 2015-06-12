From: gerg@uclinux.org (Greg Ungerer)
Date: Fri, 12 Jun 2015 11:19:43 +1000
Subject: [PATCH] ARM: mvebu: pass the coherency availability information
 at init time
In-Reply-To: <20150611145129.GA3777@kroah.com>
References: <1433992764-12753-1-git-send-email-gerg@uclinux.org>
 <20150611034521.GA12809@kroah.com> <557908C2.4090302@uclinux.org>
 <20150611092549.2276beb8@free-electrons.com>
 <20150611145129.GA3777@kroah.com>
Message-ID: <557A33AF.9030101@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/15 00:51, Greg KH wrote:
> On Thu, Jun 11, 2015 at 09:25:49AM +0200, Thomas Petazzoni wrote:
>> Greg, Greg,
>>
>> On Thu, 11 Jun 2015 14:04:18 +1000, Greg Ungerer wrote:
>>
>>>> Why?  What's wrong with taking the exact specific upstream patches
>>>> instead?
>>>
>>> The exact patch mentioned below ("5686a1e5aa4") will not apply.
>>> Too much of the code around it has changed. This does the same
>>> thing in the same away taking into account the changes around it.
>>
>> As the original author of 5686a1e5aa4 ("bus: mvebu: pass the coherency
>> availability information at init time"), I can confirm that it will
>> clearly not apply as is on 3.10. What Greg Ungerer is proposing here is
>> a backport of 5686a1e5aa4 to 3.10.
> 
> What about 3.14-stable?

As Thomas pointed out, yes. Due to file movements and other changes
neither this patch (for 3.10.y) or the original commit 5686a1e5aa4
apply cleanly to 3.14.y.

How do you want to handle that for 3.14.y?


> And if this is just a simple backport, that should have been stated
> here.

The part that said "This is done in the same way that it was done
for mainline kernels in commit" was meant to convey that meaning.
Do you want an updated patch with those exact words, "simple
backport", in the commit message?

Regards
Greg

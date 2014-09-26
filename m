From: s-anna@ti.com (Suman Anna)
Date: Fri, 26 Sep 2014 11:25:48 -0500
Subject: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
In-Reply-To: <CAJAp7Oj-3ZxvN8o=rg8YeTiXYWyQ1iowgisdU1R5UcZeh4VmOQ@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>	<1389658764-39199-5-git-send-email-s-anna@ti.com>
 <CAJAp7Oj-3ZxvN8o=rg8YeTiXYWyQ1iowgisdU1R5UcZeh4VmOQ@mail.gmail.com>
Message-ID: <5425938C.6070007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 09/26/2014 09:40 AM, Bjorn Andersson wrote:
> On Mon, Jan 13, 2014 at 4:19 PM, Suman Anna <s-anna@ti.com> wrote:
>> This patch adds three new OF helper functions to use/request
>> locks from a hwspinlock device instantiated through a
>> device-tree blob.
>>
> 
> Hi Ohad, Suman
> 
> I'm about to send out some patches that depends on this functionality,
> how do we move forward?
> 
> I still think it's wrong to not return -EPROBE_DEFER, but I much
> rather have the code returning NULL than not having it in the tree (we
> can always argue about it later...).
> 
> @Suman, do you remember if there was any other comments on the patch?

I have posted two further revisions of this series, the latest is v6
[1]. I added additional patches in v5 that added the concept of reserved
locks, and I have posted them as a separate RFC [2] for v6 so as to not
block the core DT support.

In anycase, the latest v6 version does not define the
of_hwspin_lock_request_specific() function anymore, and it is replaced
with of_hwspin_lock_get_id() function, based on Ohad's review comments
on v5, and I did add the support for -EPROBE_DEFER in this API, without
changing any of the existing return code conventions.

I am yet to receive any comments on v6, but that series should address
both your need for a probe deferral and Ohad's request to not change any
return types. Please give it a try and let me know if you have any comments.

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=141055365513902&w=2
[2] http://marc.info/?l=linux-arm-kernel&m=141055554214657&w=2

> 
> @Ohad, do you object merging Suman's patch in it's current form? I
> think it should still apply cleanly.
> 
> Regards,
> Bjorn
> 

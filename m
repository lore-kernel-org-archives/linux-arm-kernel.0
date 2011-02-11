From: davidb@codeaurora.org (David Brown)
Date: Fri, 11 Feb 2011 13:53:39 -0800
Subject: [PATCH 2/3] msm: iommu: Generalize platform data for multiple
	targets
In-Reply-To: <1297458889.4852.24.camel@m0nster> (Daniel Walker's message of
	"Fri, 11 Feb 2011 13:14:49 -0800")
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
	<1297456098-3241-2-git-send-email-stepanm@codeaurora.org>
	<1297456934.4852.11.camel@m0nster> <4D55A16A.7030300@codeaurora.org>
	<8yaipwql1wf.fsf@huya.qualcomm.com> <1297458889.4852.24.camel@m0nster>
Message-ID: <8yad3mykzks.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11 2011, Daniel Walker wrote:

> On Fri, 2011-02-11 at 13:03 -0800, David Brown wrote:
>> On Fri, Feb 11 2011, Steve Muckle wrote:

>> If they were used in more than one place, we could justify the
>> definition, but in this case, the definition just obscures the code
>> slightly.

Someone debugging it will look at the constant.  In fact, in general,
the only person looking at this structure will want to know the value in
the table.  Indirecting it through a pointer only serves to hide it from
the person who wants to know the value.

> A good example might be if all these constants are enumerated in a
> header file, but aren't all used. In that case it would be fairly easy
> to add a new resource without even know what the constant is just by
> following the pattern.

This I definitely want to avoid.  I have seen header files with hundreds
of thousands of register definitions, where only a few were used.

> I think in general this series just makes this iommu code very much
> 8660/8960 only code, but what about the potential next iteration of SoC
> that uses very similar code to this with all new constants. So this
> doesn't seem forward thinking to me.

The table would have the different addresses in it.  My point is that
the resource table _is_ the definition of the addres.  Nothing is gained
by inventing yet another name and putting that somewhere else.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

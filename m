From: bdegraaf@codeaurora.org (Brent DeGraaf)
Date: Fri, 21 Jan 2011 13:37:15 -0800 (PST)
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <8yaaaiuot1l.fsf@huya.qualcomm.com>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
	<20110120130246.GA23941@n2100.arm.linux.org.uk>
	<20110120131239.GB23941@n2100.arm.linux.org.uk>
	<1295536094.9236.11.camel@m0nster>
	<ff5d6c73aa50329b025bfe69297a92d9.squirrel@www.codeaurora.org>
	<20110121192854.GB23151@n2100.arm.linux.org.uk>
	<8yaaaiuot1l.fsf@huya.qualcomm.com>
Message-ID: <0db2f2bf1ef87fbbedecece6ae2c8d33.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks for your comments. Yes, reverting is OK. The writel's are doing the
controller write after the barrier so even though it'll be a little
slower, it will be correct.

Regarding the "unnecessary" pre-invalidate, yeah, I misspoke.  I meant
unnecessary POST-invalidates for non-speculative cpus.  I just checked and
it looks like someone's already put a "FIXME" in the current 2.6.37 source
for those.

We'll look into how much gains we can expect from the relaxed I/O calls
and decide where to go from there.  Thanks for pointing out the api.

Best regards,
Brent

On Fri, January 21, 2011 1:17 pm, David Brown wrote:
> On Fri, Jan 21 2011, Russell King - ARM Linux wrote:
>
>> On Fri, Jan 21, 2011 at 08:13:59AM -0800, Brent DeGraaf wrote:
>
>> This is one of the *biggest* problems I have with people setting up per-
>> platform mailing lists.  It hides information from the rest of the
>> community
>> and causes idiotic practices and abuses such as has happened here.
>
> I have been requesting, internally, that nothing should be sent
> to the linux-arm-msm mailing list that isn't sent to at least
> linux-arm-kernel, and preferrably linux-kernel as well.  It hasn't
> happened yet, but I will be asking people to resend patches if they only
> send them to the MSM list.
>
> As Daniel pointed out, though, I don't think this particular case was
> even discussed.  We're trying to get better.
>
> David
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

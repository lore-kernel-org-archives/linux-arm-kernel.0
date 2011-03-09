From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 8 Mar 2011 20:41:03 -0500
Subject: [PATCH 3/3] OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()
In-Reply-To: <alpine.DEB.2.00.1103081108300.10981@utopia.booyaka.com>
References: <20110308021018.31946.29962.stgit@twilight.localdomain>
	<20110308021551.31946.19903.stgit@twilight.localdomain>
	<AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
	<alpine.DEB.2.00.1103081108300.10981@utopia.booyaka.com>
Message-ID: <AANLkTikKGKqonAiMTDQk+9mvx6bU3EzYrEy6wzP+cgoq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2011 at 13:10, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 8 Mar 2011, Varadarajan, Charulatha wrote:
>
>> Do you really want to return 1 in case of invalid powerdomain pointer?
>
> Sure, that's why I wrote it that way. ?It seems less risky than returning
> 0. ?Do you have a proposal that makes more sense, given that this is going
> to be called immediately after a omap_{device,hwmod}_get_pwrdm() ?

Well. This means that it is the caller's responsibility to verify the
powerdomain pointer before calling this function. Otherwise, this
function assumes that the powerdomain looses context.

I thought that it would be appropriate to return an int value, with
which, the func would return an error in case of pwrdm ptr error,
return a zero if the powerdomain can ever loose context and a
non-zero value otherwise. What do you think?

-V Charulatha

>
>
> - Paul
>

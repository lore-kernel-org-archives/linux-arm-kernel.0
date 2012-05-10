From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 09 May 2012 17:02:27 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <CAJOA=zPtTTLc9GyPj_xnS6+J-+79mKjKhPgubmiH6Hq9B=tg1Q@mail.gmail.com>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <d460deebb832d7f62b4298c78ad2b791.squirrel@www.codeaurora.org>
 <CAJOA=zPtTTLc9GyPj_xnS6+J-+79mKjKhPgubmiH6Hq9B=tg1Q@mail.gmail.com>
Message-ID: <4FAB0593.9090502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2012 11:21 PM, Turquette, Mike wrote:
> On 20120508-19:20, skannan at codeaurora.org wrote:
>>> It might be beneficial to provide something like a
>>> __clk_reparent_start(new_parent, *scratch_pointer) and
>>> __clk_reparent_finish(*scratch_pointer) if it will be useful for more
>>> than just MSM. Based on this email, I would guess that Tegra would want
>>> something similar too.
>>
>> Thinking more about this, I think this is how any clk op that might change
>> the parent should operate. I will try to write up an RFC patch for this
>> and send it out soon. I'm in a hurry, so will explain more in the RFC
>> patch or in a later email.
>
> I'm interested to see your patch, as I might not be fully understanding
> your requirements.  Is there any reason why making nested calls to
> __clk_prepare and clk_enable from your .set_rate callback isn't enough?
>

Sorry if I wasn't clear -- my plan with the current framework IS to make 
nested (as in, inside the set rate op) calls to __clk_prepare() and 
enable() as needed. But my point is that everyone really wants to do the 
same, so we might as well make it better by putting it in the common 
code and having everyone use it instead of having to redo the same code 
all over the place.

Will send out the patch soon.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

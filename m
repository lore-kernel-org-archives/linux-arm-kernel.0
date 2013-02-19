From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 19 Feb 2013 15:41:52 -0800
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219221146.GR20312@moon>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org> <5123444D.6000806@suse.cz>
 <20130219093154.GF20312@moon> <5123BC2B.6000304@zytor.com>
 <20130219182838.GL20312@moon>
 <20130219134256.f4cedf44.akpm@linux-foundation.org>
 <20130219215432.GP20312@moon>
 <20130219140035.373ce4d2.akpm@linux-foundation.org>
 <20130219221146.GR20312@moon>
Message-ID: <51240DC0.7020302@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 02:11 PM, Cyrill Gorcunov wrote:
> On Tue, Feb 19, 2013 at 02:00:35PM -0800, Andrew Morton wrote:
>>>
>>> I think this syscall is usefull even without c/r stuff.
>>> That's why I made it with separate config option.
>>
>> hm, OK.
>>
>> But the patch also permits CONFIG_CHECKPOINT_RESTORE=y, CONFIG_KCMP=n
>> which surely isn't something which CRIU wants to support?
>
> Hmm, yes from one pov this feature is useful for out-of-c/r user,
> from another pov -- we will have to ask users to turn on additional
> CONFIG entries (which i'm sure not set by default in wide range of distros).
> Thus it seems less paiful way is either make it obj-(CHECKPOINT_RESTORE)
> as you proposed, or obj-y by default. The last can't be undone, so I'll
> prepare the patch for obj-(CHECKPOINT_RESTORE) I think.
>

Well, that's what dependencies are for.

Either way we might just want to wait for such a use case to appear, I 
don't know.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

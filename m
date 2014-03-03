From: dave.long@linaro.org (David Long)
Date: Mon, 03 Mar 2014 05:08:06 -0500
Subject: [PATCH v6 00/14] uprobes: Add uprobes support for ARM
In-Reply-To: <20140303062324.GB20583@linux.vnet.ibm.com>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
 <20140301123026.GD21483@n2100.arm.linux.org.uk> <53131DBE.7020500@linaro.org>
 <20140303062324.GB20583@linux.vnet.ibm.com>
Message-ID: <53145486.8060009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/14 01:23, Srikar Dronamraju wrote:

> It should be me who should take the blame for this and not Oleg.  This
> was discussed more than couple of times.  I can recollect couple of
> discussions here.
> http://article.gmane.org/gmane.linux.kernel/1017186
> http://article.gmane.org/gmane.linux.kernel/1001605

I wasn't trying to assign blame to anyone, I was just soliciting an 
opinion from the last uprobes maintainer I had a conversation with. 
Thanks for the links.

> I know there were more discussions on this, but I cant dig them out at
> this time.  Finally it was decided that
> 1. Users shouldnt have to select more than one config to select Uprobes.
> 2. There was no point in selecting Uprobes and not having Uprobe_event
> and vice versa.
>
>  From the above, If a user chose UPROBE_EVENT, (which is the interface
> for uprobes), we would automatically assume that he wants to use Uprobes
> framework.
>
>> like "select" is used in part maybe just to avoid the recursive
>> dependency error that would be generated if "depends on" were used
>> in both places.
>
> We did "Select Uprobes" not because of avoiding recursive dependency but
> as told above, to select the framework, given that user has chosen the
> framework. We dont want to give a choice to user to choose uprobe_event
> but not choose Uprobes or vice versa.

I suppose that's more to the point.

>> However I don't think UPROBES should be dependent on
>> UPROBE_EVENT, only the other way around.  As RK noted in previous
>
> Whats the point of having the framework(Uprobes) without an interface?
>

My comment was based only in the fact it built successfully that way on 
both x86 and ARM.  If there's no way to access the functionality without 
both selected then I suppose it does make sense to not allow that 
configuration.  Maybe it's time to remove one of these config symbols. 
I didn't see anything in the email history on this that says that would 
be a bad idea.  I'll try and come up with a patch.

-dl

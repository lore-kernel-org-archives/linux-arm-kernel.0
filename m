From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 6 Oct 2016 19:21:33 -0400
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <20161006224117.GP19539@ZenIV.linux.org.uk>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
 <20161006213734.GM19539@ZenIV.linux.org.uk>
 <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
 <20161006220050.GN19539@ZenIV.linux.org.uk>
 <20161006223729.GO19539@ZenIV.linux.org.uk>
 <20161006224117.GP19539@ZenIV.linux.org.uk>
Message-ID: <65156a02-fe6a-611f-907b-85997ee30755@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/6/2016 6:41 PM, Al Viro wrote:
> On Thu, Oct 06, 2016 at 11:37:29PM +0100, Al Viro wrote:
> 
>> If you ever get NULL in ->d_parent of struct dentry instance, you are
>> practically certain to have a dangling pointer to memory that used to
>> contain a struct dentry at some point but got freed and reused since then.
> 
> ... which is what happens in your case, apparently.  ->stats is still
> pointing to a dentry that had just been freed and its memory reused.
> 

Thanks for explaining the behavior. I posted the change a minute ago
and forgot to include you. 

dmaengine: qcom_hidma: remove useless debugfs file removal

I have a very similar problem with sysfs now. It looks like the new kernel
is more assertive than the older ones. 

I'll post the sysfs change in a minute. 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

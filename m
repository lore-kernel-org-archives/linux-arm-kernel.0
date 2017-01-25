From: labbott@redhat.com (Laura Abbott)
Date: Wed, 25 Jan 2017 12:21:05 +0100
Subject: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
In-Reply-To: <20170119075341.GA14530@amd>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
 <20170119075341.GA14530@amd>
Message-ID: <fca01775-9640-8783-a657-a9e6cf0c3e0a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2017 08:53 AM, Pavel Machek wrote:
> On Wed 2017-01-18 17:29:05, Laura Abbott wrote:
>>
>> Despite the word 'debug' in CONFIG_DEBUG_RODATA, this kernel option
>> provides key security features that are to be expected on a modern
>> system. Change the name to CONFIG_HARDENED_PAGE_MAPPINGS which more
>> accurately describes what this option is intended to do.
>
> I think this is bad change. CONFIG_DEBUG_RODATA is describing what it
> does, CONFIG_HARDENED_PAGE_MAPPINGS is advertising.
>
> We don't do advertising, and we don't force people to re-answer the
> config questions without good reason.
>
> CONFIG_HARDENED_RODATA might fix the first problem, but not the second
> one.
>
> 								Pavel
> 								

(Apologies, my SMTP was set up incorrectly so my response didn't
actually get sent out)

CONFIG_DEBUG_RODATA isn't describing what it does though. It misses
that this config may handle much more than just rodata. I think
Mark Rutland's suggestion of STRICT_KERNEL_RWX might be more
descriptive.

Thanks,
Laura

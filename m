From: labbott@redhat.com (Laura Abbott)
Date: Thu, 29 Sep 2016 18:11:44 -0700
Subject: [PATCH 1/3] arm64: dump: Make ptdump debugfs a separate option
In-Reply-To: <20160930004852.GC4369@remoulade>
References: <20160929213257.30505-1-labbott@redhat.com>
 <20160929213257.30505-2-labbott@redhat.com> <20160930001339.GA4369@remoulade>
 <e17189c7-54e0-f0a1-2b16-36f486111c4c@redhat.com>
 <20160930004852.GC4369@remoulade>
Message-ID: <cf3b51d5-f5ad-9fc3-7bea-7e7a5a9798c5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2016 05:48 PM, Mark Rutland wrote:
> On Thu, Sep 29, 2016 at 05:31:09PM -0700, Laura Abbott wrote:
>> On 09/29/2016 05:13 PM, Mark Rutland wrote:
>>> On Thu, Sep 29, 2016 at 02:32:55PM -0700, Laura Abbott wrote:
>>>> +int ptdump_register(struct ptdump_info *info, const char *name)
>>>> +{
>>>> +	ptdump_initialize(info);
>>>> +	return ptdump_debugfs_create(info, name);
>>>> }
>>>
>>> It feels like a layering violation to have the core ptdump code call the
>>> debugfs ptdump code. Is there some reason this has to live here?
>>
>> Which 'this' are you referring to here? Are you suggesting moving
>> the ptdump_register elsewhere or moving the debugfs create elsewhere?
>
> Sorry, I should have worded that better.
>
> I meant moving ptdump_register into ptdump_debugfs.c, perhaps renamed to make it
> clear it's debugfs-specific.
>
> We could instead update existing users to call ptdump_debugfs_create()
> directly, and have that call ptdump_initialize(), which could itself become a
> staic inline in a header.

Ah okay, I see what you are suggesting. ptdump_initialize should still
happen regardless of debugfs status though so I guess 
ptdump_debugfs_create would just get turned into just ptdump_initialize
which seems a little unclear. I'll come up with some other shed 
colors^W^Wfunction names.

Thanks,
Laura

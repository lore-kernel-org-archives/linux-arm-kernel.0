From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Apr 2017 23:44:09 +0200
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
References: <20170421105405.6a690b35@canb.auug.org.au>
 <CAK8P3a3kHO1NZFJXvDwWO625aEmXoo2540FRKe+YYzoYE9NCSg@mail.gmail.com>
 <4b58d5ab-c924-97af-728f-b9f524e62a53@oracle.com>
 <CAK8P3a0cVMt3y_oYH70V-ekPvUMeeBApSvybpRftSupzYy1FWQ@mail.gmail.com>
 <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
Message-ID: <CAK8P3a1mPgM4XmS398DPsSbyCyD=12xQfUrF_HRqyd52_21o7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 11:02 PM, santosh.shilimkar at oracle.com
<santosh.shilimkar@oracle.com> wrote:
> On 4/21/17 2:31 AM, Arnd Bergmann wrote:
>>
>> On Fri, Apr 21, 2017 at 8:39 AM, santosh.shilimkar at oracle.com
>> <santosh.shilimkar@oracle.com> wrote:
>>>
>>> On 4/20/17 10:53 PM, Arnd Bergmann wrote:
>>>>
>>>>
>>>> On Fri, Apr 21, 2017 at 2:54 AM, Stephen Rothwell <sfr@canb.auug.org.au>
>>>> wrote:
>>>>>
>>>>>
>>>>> Hi all,
>>>>>
>>>>> Today's linux-next merge of the pm tree got a conflict in:
>>>>>
>>>>>   include/dt-bindings/genpd/k2g.h
>>>>>
>>>>> between commit:
>>>>>
>>>>>   7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains")
>>>>>
>>>>> from the arm-soc tree and commit:
>>>>>
>>>>>   45da8edd1741 ("dt-bindings: Add TI SCI PM Domains")
>>>>>
>>>>> from the pm tree.
>>>>>
>>>>> I fixed it up (I just used the pm tree version) and can carry the fix
>>>>> as
>>>>> necessary. This is now fixed as far as linux-next is concerned, but any
>>>>> non trivial conflicts should be mentioned to your upstream maintainer
>>>>> when your tree is submitted for merging.  You may also want to consider
>>>>> cooperating with the maintainer of the conflicting tree to minimise any
>>>>> particularly complex conflicts.
>>>>
>>>>
>>>>
>>>> Dave, Santosh,
>>>>
>>>> any idea what happened here? It seems that we picked up the wrong
>>>> version of the tree, do we need to drop this from arm-soc?
>>>>
>>> Nope. Its because this series was in my 'next' branch for a week or
>>> so and now it made it via arm-soc tree next as well.
>>>
>>> I just cleaned up my next head so it linux-next next tag should have
>>> only arm-soc copy.
>>
>>
>> I still see two conflicting trees in linux-next as of today, neither of
>> them is your keystone tree:
>>
> In the list it was agreed that the patchset goes via arm-soc tree.
>
> ae3874c ARM: keystone: Drop PM domain support for k2g
> 52835d5 soc: ti: Add ti_sci_pm_domains driver
> 7cc119f dt-bindings: Add TI SCI PM Domains
> 213ec7f PM / Domains: Do not check if simple providers have phandle cells
> a5ea7a0 PM / Domains: Add generic data pointer to genpd data struct
>
>> arm-soc/next/drivers:
>> ae3874cc931b ARM: keystone: Drop PM domain support for k2g
>> 52835d59fc6c soc: ti: Add ti_sci_pm_domains driver
>> 7cc119f29b19 dt-bindings: Add TI SCI PM Domains
>> 213ec7fed302 PM / Domains: Do not check if simple providers have phandle
>> cells
>> a5ea7a0fcbd7 PM / Domains: Add generic data pointer to genpd data struct
>>
> Above are the correct git object for which I sent pull request for.

Ok, good, thanks for checking! They are however the commits that
contain the silly https://urldefense.proofpoint.com URLs. Can you
send a follow-up patch to fix these and use the regular http://www.ti.org
URL that is in linux-next?

       Arnd

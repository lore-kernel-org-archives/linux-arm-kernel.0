From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Fri, 21 Apr 2017 14:02:35 -0700
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <CAK8P3a0cVMt3y_oYH70V-ekPvUMeeBApSvybpRftSupzYy1FWQ@mail.gmail.com>
References: <20170421105405.6a690b35@canb.auug.org.au>
 <CAK8P3a3kHO1NZFJXvDwWO625aEmXoo2540FRKe+YYzoYE9NCSg@mail.gmail.com>
 <4b58d5ab-c924-97af-728f-b9f524e62a53@oracle.com>
 <CAK8P3a0cVMt3y_oYH70V-ekPvUMeeBApSvybpRftSupzYy1FWQ@mail.gmail.com>
Message-ID: <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/21/17 2:31 AM, Arnd Bergmann wrote:
> On Fri, Apr 21, 2017 at 8:39 AM, santosh.shilimkar at oracle.com
> <santosh.shilimkar@oracle.com> wrote:
>> On 4/20/17 10:53 PM, Arnd Bergmann wrote:
>>>
>>> On Fri, Apr 21, 2017 at 2:54 AM, Stephen Rothwell <sfr@canb.auug.org.au>
>>> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the pm tree got a conflict in:
>>>>
>>>>   include/dt-bindings/genpd/k2g.h
>>>>
>>>> between commit:
>>>>
>>>>   7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains")
>>>>
>>>> from the arm-soc tree and commit:
>>>>
>>>>   45da8edd1741 ("dt-bindings: Add TI SCI PM Domains")
>>>>
>>>> from the pm tree.
>>>>
>>>> I fixed it up (I just used the pm tree version) and can carry the fix as
>>>> necessary. This is now fixed as far as linux-next is concerned, but any
>>>> non trivial conflicts should be mentioned to your upstream maintainer
>>>> when your tree is submitted for merging.  You may also want to consider
>>>> cooperating with the maintainer of the conflicting tree to minimise any
>>>> particularly complex conflicts.
>>>
>>>
>>> Dave, Santosh,
>>>
>>> any idea what happened here? It seems that we picked up the wrong
>>> version of the tree, do we need to drop this from arm-soc?
>>>
>> Nope. Its because this series was in my 'next' branch for a week or
>> so and now it made it via arm-soc tree next as well.
>>
>> I just cleaned up my next head so it linux-next next tag should have
>> only arm-soc copy.
>
> I still see two conflicting trees in linux-next as of today, neither of
> them is your keystone tree:
>
In the list it was agreed that the patchset goes via arm-soc tree.

ae3874c ARM: keystone: Drop PM domain support for k2g
52835d5 soc: ti: Add ti_sci_pm_domains driver
7cc119f dt-bindings: Add TI SCI PM Domains
213ec7f PM / Domains: Do not check if simple providers have phandle cells
a5ea7a0 PM / Domains: Add generic data pointer to genpd data struct

> arm-soc/next/drivers:
> ae3874cc931b ARM: keystone: Drop PM domain support for k2g
> 52835d59fc6c soc: ti: Add ti_sci_pm_domains driver
> 7cc119f29b19 dt-bindings: Add TI SCI PM Domains
> 213ec7fed302 PM / Domains: Do not check if simple providers have phandle cells
> a5ea7a0fcbd7 PM / Domains: Add generic data pointer to genpd data struct
>
Above are the correct git object for which I sent pull request for.

> pm/pm-domains:
> 9da73c55f95f ARM: keystone: Drop PM domain support for k2g
> 112572283742 soc: ti: Add ti_sci_pm_domains driver
> 45da8edd1741 dt-bindings: Add TI SCI PM Domains
> b1013fa55589 PM / Domains: Do not check if simple providers have phandle cells
> 7030fc004df9 PM / Domains: Add generic data pointer to genpd data struct
The above git object don't exist in my tree so am not sure about these
objects. I Just checked Rafael's pm-domains head and that also don't
have these objects.

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-domains


> b539cc82d493 PM / Domains: Ignore domain-idle-states that are not compatible
> 075c37d59ecd PM / Domains: Don't warn about IRQ safe device for an
> always on PM domain
> 1c14967c6ea0 PM / Domains: Respect errors from genpd's ->power_off() callback
> ffaa42e8a40b PM / Domains: Enable users of genpd to specify always on PM domains
> 41e2c8e0060d PM / Domains: Clean up code validating genpd's status
> 8ce95844c853 PM / Domain: remove conditional from error case
>
> For all I can tell (and matching what Stephen found), the version in
> the 'pm' tree
> is the one you intended to send, while the version we merged into arm-soc
> has not only a different git commit ID but also some odd comments that
> are not present in the PM version:
>
See above. The one in arm-soc tree is what I sent as pull request. Am
also confused for the git objects you pointed out in pm/pm-domains.
If they are not on the source pm-domains tree then how they landed
up in linux-next ?

Regards,
Santosh

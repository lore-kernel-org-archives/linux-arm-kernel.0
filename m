From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 Oct 2013 09:45:05 +0100
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131025082229.GD19622@ulmo.nvidia.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <1382544332.8522.40.camel@shinybook.infradead.org>
 <20131023185114.GA7863@ulmo.nvidia.com> <52699E8B.3000305@wwwdotorg.org>
 <20131025082229.GD19622@ulmo.nvidia.com>
Message-ID: <526A2F91.1070408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 09:22 AM, Thierry Reding wrote:
> On Thu, Oct 24, 2013 at 11:26:19PM +0100, Stephen Warren wrote:
>> On 10/23/2013 07:51 PM, Thierry Reding wrote:
>>> On Wed, Oct 23, 2013 at 05:05:32PM +0100, David Woodhouse
>>> wrote:
>>>> On Wed, 2013-10-23 at 17:06 +0200, Thierry Reding wrote:
>>>>> +       /* check if binding is experimental */ +       if
>>>>> (dev != device || drv != driver) { +
>>>>> pr_warn("of: device %s (%s) uses an experimental
>>>>> binding\n", +                       np->name,
>>>>> np->full_name); +
>>>> 
>>>> In the discussions earlier I think we decided that this
>>>> should set a taint flag too.
>>> 
>>> A taint flag seems somewhat drastic. It's not like using an
>>> experimental binding should have an influence on the stability
>>> of the running kernel. I always thought that taint flags were
>>> supposed to flag conditions where code of unknown origin or
>>> code known to be broken was being executed because they may
>>> destabilize the running kernel.
>>> 
>>> The worst that should happen if you run an experimental binding
>>> is that some part of the system will just not come up.
>> 
>> IIRC, the purpose of the taint flag was to make it clear that the
>> kernel or DT was not expected to function in the future, so don't
>> be surpised if you upgrade it, and it stops working, without you
>> taking explicit action, such as revising your DT to match the new
>> kernel or vice-versa.
> 
> I understand that, but I was arguing that it doesn't match existing
> uses of taint flags. The various flags that are currently defined
> all seem to be set whenever some event occurs that could cause
> instability of the currently running system, such as loading a
> proprietary or out-of-tree module, forcing a module to be loaded,
> overriding firmware parameters...

Executing a driver that supports an unstable binding does produce
instability in the system; the kernel configuration might not continue
to work if rebooted with an updated DT. Admittedly, this is a slightly
different concept than other taint flags, but seems like a logical
extension.

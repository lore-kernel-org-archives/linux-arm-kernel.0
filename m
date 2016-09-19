From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Mon, 19 Sep 2016 14:41:10 -0400
Subject: [RFC] arm64: Ensure proper addressing for ldnp/stnp
In-Reply-To: <50fcc549-d785-6332-83bd-292a4f44e8d4@redhat.com>
References: <1474306586-25118-1-git-send-email-bdegraaf@codeaurora.org>
 <50fcc549-d785-6332-83bd-292a4f44e8d4@redhat.com>
Message-ID: <13521f9f5ebe1cd0a85bf31b5ad5cba0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-19 14:28, Laura Abbott wrote:
> On 09/19/2016 10:36 AM, Brent DeGraaf wrote:
>> According to section 6.3.8 of the ARM Programmer's Guide, non-temporal
>> loads and stores do not verify that address dependency is met between 
>> a
>> load of an address to a register and a subsequent non-temporal load or
>> store using that address on the executing PE. Therefore, context 
>> switch
>> code and subroutine calls that use non-temporally accessed addresses 
>> as
>> parameters that might depend on a load of an address into an argument
>> register must ensure that ordering requirements are met by introducing
>> a barrier prior to the successive non-temporal access.  Add 
>> appropriate
>> barriers whereever this specific situation comes into play.
>> 
> 
> Was this found by code inspection or is there a (public) exciting test
> case to observe this behavior?
> 
> Thanks,
> Laura
> 

Code inspection only.

Brent

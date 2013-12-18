From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Dec 2013 13:44:09 +0000
Subject: [PATCH 2/2] kvmtool/arm: Add option to override Generic Timer
 frequency
In-Reply-To: <308D5B7E-5BDA-4984-9448-EAD8B5D699CF@suse.de>
References: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
 <1387305074-29421-3-git-send-email-robin.murphy@arm.com>
 <308D5B7E-5BDA-4984-9448-EAD8B5D699CF@suse.de>
Message-ID: <52B1A6A9.1030107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/13 20:39, Alexander Graf wrote:
>
> On 17.12.2013, at 19:31, Robin Murphy <robin.murphy@arm.com> wrote:
>
>> Some platforms have secure firmware which does not correctly set the
>> CNTFRQ register on boot, preventing the use of the Generic Timer.
>> This patch allows mirroring the necessary host workaround by specifying
>> the clock-frequency property in the guest DT.
>>
>> This should only be considered a means of KVM bring-up on such systems,
>> such that vendors may be convinced to properly implement their firmware
>> to support the virtualisation capabilities of their hardware.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>
> How does it encourage a vendor to properly implement their firmware if there's a workaround?
>
>
> Alex
>
>

Hi Alex,

In short, by enabling the users to create the demand. Yes, like any 
workaround there's potential for abuse, but having *something* that 
makes it work is the difference between "I want virtualisation"[1] and 
"Dear vendor, I've tried virtualisation on your chip/board and it's 
great, but it tells me I need new firmware, where do I get that?"

Having the specs tell them what to do clearly isn't sufficient, so let's 
give the integrators and consumers incentive to shout at them too. The 
sooner proper support is commonplace and we can deprecate 
clock-frequency hacks altogether, the better.

Robin.

[1] 
http://www.theregister.co.uk/2013/12/12/virtualisation_on_mobile_phones_is_coming/

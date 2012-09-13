From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 12:33:18 -0600
Subject: [PATCH] ARM: Tegra: Add smp_twd clock for Tegra20
In-Reply-To: <20120913182749.3094.64766@nucleus>
References: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
 <5052027F.1000404@wwwdotorg.org> <5052174A.8090701@wwwdotorg.org>
 <20120913182749.3094.64766@nucleus>
Message-ID: <505226EE.70201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 12:27 PM, Mike Turquette wrote:
> Quoting Stephen Warren (2012-09-13 10:26:34)
>> On 09/13/2012 09:57 AM, Stephen Warren wrote:
>>> On 09/13/2012 03:34 AM, Prashant Gaikwad wrote:
>>>> Clockevent's frequency is changed upon cpufreq change
>>>> notification. It fetches local timer's rate to update the
>>>> clockevent frequency. This patch adds local timer clock
>>>> for Tegra20.
>>>
>>> Hmm. Off-list, I'd asked you to check whether this patch, and Mike's
>>> twd/clk-notifier changes were OK for Tegra, and part of your reponse was:
>>>
>>> Tegra20 (Ventana)
>>>         Tegra's for-next (common clock) + smp_twd : Panic
>>>
>>> Is that true? If so, I can't apply this patch...
>>
>> Oh, perhaps you mean the warning below? That's exactly the issue that
>> Mike's patch was intended to solve, so it's not surprising that it'd be
>> seen as soon as we actually implement the smp_twd clock. If that's all,
>> then it seems OK to apply this.
>>
> 
> Can you confirm that the problem goes away with this patch:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/187488/match=

Yes, it does.

That patch is what triggered the creation of this patch (since because
of it I noticed we didn't have the smp_twd clock in our driver).

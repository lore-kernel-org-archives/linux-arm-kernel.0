From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 10 Jul 2015 17:41:11 +0530
Subject: [PATCH 3/3] regulator: 88pm800: Add dev_info to show probe success
 status
In-Reply-To: <20150709190547.GQ11162@sirena.org.uk>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
 <20150709190547.GQ11162@sirena.org.uk>
Message-ID: <559FB65F.4060601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 12:35 AM, Mark Brown wrote:
> On Thu, Jul 09, 2015 at 06:11:32PM +0530, Vaibhav Hiremath wrote:
>> This patch adds dev_info line at the end of probe function, to
>> clearly put status of regulator probe on console. Useful during
>> development, specially to check bootlog.
>
>> +	dev_info(&pdev->dev, "Regulator registered ...\n");
>>   	return 0;
>
> No, this is pure noise - all you're doing is slowing down boot for users
> with no content.  Think about what would happen if every driver did
> this.  The core already displays the constraints when things are
> registered.
>


I was just trying my luck here :)

And honestly, this was useful for me atleast.

Thanks,
Vaibhav

From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 16 Mar 2015 09:37:11 +0100
Subject: [PATCH 3/9] amba: Keep PM domain powered during ->probe()
In-Reply-To: <20150313160341.GQ8656@n2100.arm.linux.org.uk>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
 <20150313160341.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFr9W+eHFRzR5O+2em9EUiiW=oDrKCaG196yD7NgtPL90g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2015 at 17:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 13, 2015 at 04:43:43PM +0100, Ulf Hansson wrote:
>> To sucessfully probe some devices their corresponding PM domains may
>> need to be powered.
>>
>> Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
>> domain.
>
> Given that AMBA gets the runtime PM status across a probe, none of this
> should be necessary, as generic PM domains ensures that if runtime PM
> is active for any device bound to the PM domain, the PM domain will be
> powered up.

This patch is needed to enable us to do the revert in patch 9. Since
otherwise amba drivers will probe their devices when the attached PM
domain may be powered off.

That should have been better explained in the commit message.

Kind regards
Uffe

>
> In that respect, AMBA is a model of how runtime PM should've been done
> for stuff like platform devices. :)
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
